//
//  DgWidgetLiveActivity.swift
//  DgWidget
//
//  Created by 신동규 on 5/20/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DgWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DgWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DgWidgetAttributes.self) { context in
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

extension DgWidgetAttributes {
    fileprivate static var preview: DgWidgetAttributes {
        DgWidgetAttributes(name: "World")
    }
}

extension DgWidgetAttributes.ContentState {
    fileprivate static var smiley: DgWidgetAttributes.ContentState {
        DgWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DgWidgetAttributes.ContentState {
         DgWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DgWidgetAttributes.preview) {
   DgWidgetLiveActivity()
} contentStates: {
    DgWidgetAttributes.ContentState.smiley
    DgWidgetAttributes.ContentState.starEyes
}
