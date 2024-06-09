//
//  SceneDelegate.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import UIKit
import Presentation

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            print("dg: shortcutItem is \(shortcutItem)")
        }
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("dg: shortcutItem is \(shortcutItem)")
        completionHandler(true)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for context in URLContexts {
            let url = context.url
            guard let scheme = url.scheme, let host = url.host() else { return }
            guard scheme == "dgmuscle" else { return }
            
            switch host {
            case "friend":
                coordinator?.friendMainView()
            case "profile":
                coordinator?.profile()
            case "exercisemanage":
                coordinator?.exerciseManage()
            default: break
            }
        }
    }
}
