//
//  DeleteAccountStatus.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation

public enum DeleteAccountStatus {
    case start
    case loading
    case error(Error)
}
