//
//  HistoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct HistoryData: Codable {
    let id: String
    let date: String
    let memo: String?
    let records: [RecordData]
}
