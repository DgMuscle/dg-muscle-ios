//
//  User.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public let USER_DG: User = .init(
    uid: "taEJh30OpGVsR3FEFN2s67A8FvF3",
    displayName: "DG", 
    backgroundImageURL: .init(string: "https://i.pinimg.com/564x/6f/9c/3e/6f9c3e191d2b4fe3772d39af645227d7.jpg"),
    photoURL: .init(
        string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FtaEJh30OpGVsR3FEFN2s67A8FvF3%2F6DB88FAB-95C0-43E9-8E3C-144728415F78.png?alt=media&token=f8feaa40-a306-4c01-8396-e40662bb4ecc"
    ),
    heatMapColor: .purple, 
    fcmToken: nil, 
    link: .init(string: "https://github.com/donggyushin")
)


public let USER_1: User = .init(
    uid: "2Mwgf4vpKLRyz1ynuWBwvcyEBe92",
    displayName: "Hui",
    backgroundImageURL: nil,
    photoURL: nil,
    heatMapColor: .green,
    fcmToken: nil, 
    link: nil
)

public let USER_2: User = .init(
    uid: "5cLTF5EVsMdtOgYpl6RQKi9xVCE3",
    displayName: nil,
    backgroundImageURL: nil,
    photoURL: .init(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2F56mGcK9Nm5cVcUk8vxW5h9jIQcA2%2FFDED5B8E-229B-4EAE-BEF8-912E5C41D7D6.png?alt=media&token=f74e7d94-c050-461c-98bd-c2e8ded5f9c8"),
    heatMapColor: .green,
    fcmToken: nil,
    link: nil
)

public let USER_3: User = .init(
    uid: "nkKKFlPlBTN14cAlOgnwNC0rmel2",
    displayName: "JIN",
    backgroundImageURL: .init(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FtaEJh30OpGVsR3FEFN2s67A8FvF3%2F9F14BFF8-33CE-40BF-822F-BB834CE379FE.png?alt=media&token=bca448b7-f0e6-48fe-9a78-c309220fe7bb"),
    photoURL: .init(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FnkKKFlPlBTN14cAlOgnwNC0rmel2%2F559DE7D0-33AD-4BA0-8093-BD1E95276263.png?alt=media&token=8793f93b-e87e-4a43-81b9-d25cd4c083d2"),
    heatMapColor: .mint,
    fcmToken: nil,
    link: nil
)

public let USER_4: User = .init(
    uid: "56mGcK9Nm5cVcUk8vxW5h9jIQcA2",
    displayName: "낙용",
    backgroundImageURL: .init(string: "https://i.pinimg.com/564x/6f/9c/3e/6f9c3e191d2b4fe3772d39af645227d7.jpg"),
    photoURL: .init(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2F56mGcK9Nm5cVcUk8vxW5h9jIQcA2%2FFDED5B8E-229B-4EAE-BEF8-912E5C41D7D6.png?alt=media&token=f74e7d94-c050-461c-98bd-c2e8ded5f9c8"),
    heatMapColor: .mint,
    fcmToken: nil,
    link: .init(string: "https://github.com/donggyushin")
)
