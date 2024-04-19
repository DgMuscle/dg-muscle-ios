//
//  FileUploaderInterface.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/17/24.
//

import UIKit

protocol FileUploaderInterface {
    func uploadImage(path: String, image: UIImage) async throws -> URL
    func deleteImage(path: String) async throws
}
