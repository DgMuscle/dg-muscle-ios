//
//  UserData.swift
//  MockData
//
//  Created by 신동규 on 7/27/24.
//

import Foundation
import Domain

public var USERS: [Domain.User] {
    var users: [Domain.User] = []
    
    guard let filePath = Bundle(for: ForBundle.self).url(forResource: "all_users", withExtension: "json") else { return users }
    guard let data = try? Data(contentsOf: filePath) else { return users }
    let decoder = JSONDecoder()
    if let decoded = try? decoder.decode([UserMockData].self, from: data) {
        users = decoded.map({ $0.domain })
    }
    return users
}

public var USER_DG: Domain.User {
    USERS.first(where: { $0.uid == "taEJh30OpGVsR3FEFN2s67A8FvF3" })!
}

private class ForBundle { }
