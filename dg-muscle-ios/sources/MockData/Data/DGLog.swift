//
//  DGLog.swift
//  MockData
//
//  Created by 신동규 on 6/22/24.
//

import Foundation
import Domain

let LOG_1: DGLog = .init(
    id: "1",
    category: .error,
    message: "sample error",
    resolved: false,
    createdAt: createdDate(from: "2024-06-22"),
    creator: "taEJh30OpGVsR3FEFN2s67A8FvF3"
)

let LOG_2: DGLog = .init(
    id: "2",
    category: .log,
    message: "sample log",
    resolved: false,
    createdAt: createdDate(from: "2024-06-20"),
    creator: "taEJh30OpGVsR3FEFN2s67A8FvF3"
)

private func createdDate(from string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: string) ?? Date()
}
