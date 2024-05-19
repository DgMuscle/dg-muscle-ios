//
//  Volume.swift
//  HeatMap
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public struct Volume: Hashable {
    public let id: String = UUID().uuidString
    public let value: Double
}
