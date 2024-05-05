//
//  HistoryURL.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/24/24.
//

import Foundation

extension FunctionsURL {
    enum History: String {
        case deletehistory
        case gethistories
        case getfriendhistories
        case posthistory
        
        var value: String {
            return "v4history-\(self.rawValue)"
        }
    }
}

extension FunctionsURL {
    enum User: String {
        case getprofiles
        case getprofile
        case postprofile
        case getprofilefromuid
        
        var value: String {
            return "v4user-\(self.rawValue)"
        }
    }
}

extension FunctionsURL {
    enum Friend: String {
        case deleterequest
        case getfriends
        case delete
        case post
        case getrequests
        case postrequest
        
        var value: String {
            return "v4friend-\(self.rawValue)"
        }
    }
}

extension FunctionsURL {
    enum Exercise: String {
        case deleteexercise
        case getexercises
        case postexercise
        
        var value: String {
            return "v4exercise-\(self.rawValue)"
        }
    }
}
