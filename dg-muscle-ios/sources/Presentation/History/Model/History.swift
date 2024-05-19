//
//  History.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import SwiftUI

struct History: Hashable {
    let id: String
    let date: Date
    let parts: [String]
    let volume: Double
    let color: Color
    let time: Double?
    let kcal: Double?
}