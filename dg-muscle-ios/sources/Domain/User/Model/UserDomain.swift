//
//  UserDomain.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation

public struct UserDomain {
    public let uid: String
    public var displayName: String?
    public var photoURL: URL?
    
    public init(uid: String, displayName: String? = nil, photoURL: URL? = nil) {
        self.uid = uid
        self.displayName = displayName
        self.photoURL = photoURL
    }
}
