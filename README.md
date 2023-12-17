## Learn how to add a Home Screen Widget

📲👉 https://blog.nativescript.org/add-home-screen-widget/

## Notes to run it yourself

1. This example uses it's own `DEVELOPMENT_TEAM` and `PROVISIONING_PROFILE`'s for both the app and the widget as well as it's own App ID's for both.
2. In order to run the example and experiment yourself, you will need to swap the following:

- `App_Resources/iOS/build.xcconfig`: 
  - Change `DEVELOPMENT_TEAM` to your own.
  - Change `PROVISIONING_PROFILE` to the name of the provision profile you create for the app itself.
- `App_Resources/iOS/extensions/provisioning.json`: modify the key to match the App ID of your widget and the value to the name of the provision profile you create for the widget itself, for example:

```json
{
    // This is the APP ID of the Widget      // Widget Provision Name
    "org.nativescript.widgetexample.widget": "WidgetExampleWidget"
}
```

- `App_Resources/iOS/app.entitlements`: Update `group.org.nativescript.widgetexample` to the App Group ID you registered in your Apple Developer account.
- `App_Resources/iOS/extensions/widget/widget.entitlements`: Update `group.org.nativescript.widgetexample` to match App Group ID you registered in your Apple Developer account.
- Lastly, search for all occurrences of `group.org.nativescript.widgetexample` and update those to match your App Group ID.