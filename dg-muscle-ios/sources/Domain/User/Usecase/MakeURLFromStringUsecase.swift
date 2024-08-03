//
//  MakeURLFromStringUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/3/24.
//

import Foundation
import UIKit

public final class MakeURLFromStringUsecase {
    public init() { }
    
    public func implement(link: String) -> URL? {
        var result: URL?
        
        var link = link
        
        if link.isEmpty {
            return result
        }
        
        let hasPrefix = link.hasPrefix("https://") || link.hasPrefix("http://")
        
        if !hasPrefix {
            link = "https://\(link)"
        }
        
        result = .init(string: link)
        
        return result
    }
}
