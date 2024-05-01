//
//  dg_muscle_ios_widgetLiveActivity.swift
//  dg-muscle-ios-widget
//
//  Created by 신동규 on 10/15/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct dg_muscle_ios_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct dg_muscle_ios_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: dg_muscle_ios_widgetAttributes.self) { context in
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

extension dg_muscle_ios_widgetAttributes {
    fileprivate static var preview: dg_muscle_ios_widgetAttributes {
        dg_muscle_ios_widgetAttributes(name: "World")
    }
}

extension dg_muscle_ios_widgetAttributes.ContentState {
    fileprivate static var smiley: dg_muscle_ios_widgetAttributes.ContentState {
        dg_muscle_ios_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: dg_muscle_ios_widgetAttributes.ContentState {
         dg_muscle_ios_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: dg_muscle_ios_widgetAttributes.preview) {
   dg_muscle_ios_widgetLiveActivity()
} contentStates: {
    dg_muscle_ios_widgetAttributes.ContentState.smiley
    dg_muscle_ios_widgetAttributes.ContentState.starEyes
}
