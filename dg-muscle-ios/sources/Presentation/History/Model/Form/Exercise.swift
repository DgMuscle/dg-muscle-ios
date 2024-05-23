//
//  Exercise.swift
//  History
//
//  Created by Donggyu Shin on 5/23/24.
//

import Foundation
import Domain

struct Exercise: Hashable {
    let id: String
    let name: String
    let favorite: Bool
    
    init(domain: Domain.Exercise) {
        self.id = domain.id
        self.name = domain.name
        self.favorite = domain.favorite
    }
}
