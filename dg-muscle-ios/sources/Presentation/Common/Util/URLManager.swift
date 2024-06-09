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
}
