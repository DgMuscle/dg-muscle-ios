//
//  GrassData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 12/23/23.
//

import Foundation

struct GrassData: Identifiable, Equatable {
    let id = UUID().uuidString
    let date: String
    let value: Double
}
