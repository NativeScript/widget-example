import Foundation
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(message: "Hello Widget")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(message: "Hello Widget")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = [];

        let message = UserDefaults(suiteName: "group.org.nativescript.widgetexample")!.string(forKey: "MESSAGES");
        let entry = SimpleEntry(message: message ?? "")
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = Date()
    var message: String = ""
}

struct widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.message)
                .font(.system(size: 24, weight: .black))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Image("NSLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)

            if (entry.message == "and innovative native platform tech.") {
                Text("🚀") 
            }
        }
    }
}

struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                widgetEntryView(entry: entry)
                    .containerBackground(for:.widget) {
                        Color(red: 0.396, green: 0.678, blue: 0.945) // #65adf1
                    }
            } else {
                widgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("NativeScript Widget")
        .description("Sky is the limit.")
    }
}

#Preview(as: .systemSmall) {
    widget()
} timeline: {
    SimpleEntry(message: "😀")
}
