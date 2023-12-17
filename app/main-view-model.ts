import {
  Application,
  CoreTypes,
  GridLayout,
  Observable,
  Screen,
} from "@nativescript/core";

export class HelloWorldModel extends Observable {
  rocket: GridLayout;
  private _counter: number;
  private _message: string;
  private _userDefaults: NSUserDefaults;
  private readonly VALUE_KEY = "MESSAGES";
  private _messages = [
    "Let's add a widget with NativeScript",
    "Seamlessly...",
    "move between...",
    "cutting edge web tech...",
    "and innovative native platform tech.",
  ];

  constructor() {
    super();

    // Initialize default values.
    this._counter = 0;
    this.updateMessage();

    Application.on(Application.resumeEvent, () => {
      if (this.rocket && this._counter === this._messages.length - 1) {
        // resumed app on last message, make rocket take off
        this.rocket.visibility = CoreTypes.Visibility.visible;
        this.rocket.animate({
          translate: { x: 0, y: 0 },
          scale: { x: 5, y: 5 },
          opacity: 0,
          duration: 2000,
          curve: CoreTypes.AnimationCurve.easeInOut,
        });
      }
    });
  }

  get message(): string {
    return this._message;
  }

  set message(value: string) {
    if (this._message !== value) {
      this._message = value;
      this.notifyPropertyChange("message", value);
    }
  }

  loadedRocket(args) {
    if (!this.rocket) {
      this.rocket = args.object;
      this.rocket.visibility = CoreTypes.Visibility.hidden;
      this.rocket.translateY = Screen.mainScreen.heightDIPs - 80;
    }
  }

  onTap() {
    this._counter++;
    this.updateMessage();
    this.updateSharedValue();
  }

  private getGroupId(): string {
    return `group.${__IOS__ ? NSBundle.mainBundle.bundleIdentifier : null}`;
  }

  private updateSharedValue() {
    if (__IOS__) {
      if (!this._userDefaults) {
        this._userDefaults = NSUserDefaults.alloc().initWithSuiteName(
          this.getGroupId()
        );
      }
      this._userDefaults.setObjectForKey(this.message, this.VALUE_KEY);
      NSCUtilsHelper.updateWidget();
    }
  }

  private updateMessage() {
    if (this._counter < this._messages.length) {
      this.message = this._messages[this._counter];
    } else {
      this._counter = 0;
    }
  }
}
