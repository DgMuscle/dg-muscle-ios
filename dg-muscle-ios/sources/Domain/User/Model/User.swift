//
//  User.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation

public struct User {
    public let uid: String
    public let displayName: String?
    public let photoURL: URL?
    
    public init(uid: String, displayName: String? = nil, photoURL: URL? = nil) {
        self.uid = uid
        self.displayName = displayName
        self.photoURL = photoURL
    }
}
