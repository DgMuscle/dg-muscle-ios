//
//  Friend.swift
//  MockData
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain

public let FRIEND_1 = USER_4


public let FRIEND_REQUEST_1: Domain.FriendRequest = .init(fromId: USER_3.uid, createdAt: generateDate(date: "20240526"))
public let FRIEND_REQUEST_2: Domain.FriendRequest = .init(fromId: USER_2.uid, createdAt: generateDate(date: "20240426"))

func generateDate(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    return dateFormatter.date(from: date) ?? Date()
}
