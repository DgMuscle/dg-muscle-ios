//
//  WidgetTestPleaseLiveActivity.swift
//  WidgetTestPlease
//
//  Created by 신동규 on 5/20/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetTestPleaseAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetTestPleaseLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetTestPleaseAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetTestPleaseAttributes {
    fileprivate static var preview: WidgetTestPleaseAttributes {
        WidgetTestPleaseAttributes(name: "World")
    }
}

extension WidgetTestPleaseAttributes.ContentState {
    fileprivate static var smiley: WidgetTestPleaseAttributes.ContentState {
        WidgetTestPleaseAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetTestPleaseAttributes.ContentState {
         WidgetTestPleaseAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetTestPleaseAttributes.preview) {
   WidgetTestPleaseLiveActivity()
} contentStates: {
    WidgetTestPleaseAttributes.ContentState.smiley
    WidgetTestPleaseAttributes.ContentState.starEyes
}
