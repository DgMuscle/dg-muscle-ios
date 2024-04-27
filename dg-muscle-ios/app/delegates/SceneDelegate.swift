//
//  SceneDelegate.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            handleUIApplicationShortCutItem(item: shortcutItem)
        }
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        handleUIApplicationShortCutItem(item: shortcutItem)
        completionHandler(true)
    }
    
    private func handleUIApplicationShortCutItem(item: UIApplicationShortcutItem) {
        switch item.type {
        case QuickAction.Actiontype.record.rawValue:
            RemoteCoordinator.shared.quickAction(quickAction: .init(type: .record))
        default: break
        }
    }
}
