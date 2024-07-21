//
//  FunctionsURLEnum.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
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
        case deleteaccount
        
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
        case getexercisesfromuid
        
        var value: String {
            return "v4exercise-\(self.rawValue)"
        }
    }
}

extension FunctionsURL {
    enum Log: String {
        case postlog
        case getlogs
        
        var value: String {
            return "v4log-\(self.rawValue)"
        }
    }
}

extension FunctionsURL {
    enum RapidAPI: String {
        case getapikey
        
        var value: String {
            return "rapidapi-\(self.rawValue)"
        }
    }
}
