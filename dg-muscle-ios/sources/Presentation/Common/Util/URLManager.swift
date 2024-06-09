//
//  URLManager.swift
//  Common
//
//  Created by 신동규 on 6/9/24.
//

import UIKit

public final class URLManager {
    public static let shared = URLManager()
    
    private init() { }
    
    public func open(url: String, completionHandler: ((Bool) -> (Void))? = nil) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url, completionHandler: completionHandler)
    }
    
    public func getParameter(url: URL, name: String) -> String? {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let value = components.queryItems?.first(where: { $0.name == name })?.value {
                return value
            }
        }
        return nil 
    }
}
