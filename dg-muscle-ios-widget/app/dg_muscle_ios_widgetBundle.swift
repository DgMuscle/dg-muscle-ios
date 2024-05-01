//
//  dg_muscle_ios_widgetBundle.swift
//  dg-muscle-ios-widget
//
//  Created by 신동규 on 10/15/23.
//

import WidgetKit
import SwiftUI

@main
struct dg_muscle_ios_widgetBundle: WidgetBundle {
    var body: some Widget {
        dg_muscle_ios_widget()
        dg_muscle_ios_widgetLiveActivity()
    }
}
