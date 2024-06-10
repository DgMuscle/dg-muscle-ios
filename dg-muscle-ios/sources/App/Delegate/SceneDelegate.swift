//
//  SceneDelegate.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import UIKit
import Presentation
import Friend
import Common

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            print("dg: shortcutItem is \(shortcutItem)")
        }
        
        if let urlContext = connectionOptions.urlContexts.first {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.handleURL(url: urlContext.url)
            }
        }
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("dg: shortcutItem is \(shortcutItem)")
        completionHandler(true)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.map({ $0.url }).first else { return }
        handleURL(url: url)
    }
    
    private func handleURL(url: URL) {
        guard let scheme = url.scheme, let host = url.host() else { return }
        guard scheme == "dgmuscle" else { return }
        
        switch host {
        case "friend":
            var anchor: PageAnchorView.Page = .friend
            
            let anchorString = URLManager.shared.getParameter(url: url, name: "anchor")
            
            switch anchorString {
            case "friend":
                anchor = .friend
            case "request":
                anchor = .request
            case "search":
                anchor = .search
            default: break
            }
            
            coordinator?.friendMainView(anchor: anchor)
        case "profile":
            coordinator?.profile()
        case "exercisemanage":
            coordinator?.exerciseManage()
        case "heatmapcolorselect":
            coordinator?.heatMapColorSelectView()
        case "history":
            let historyId = URLManager.shared.getParameter(url: url, name: "id")
            coordinator?.historyFormStep1(historyId: historyId)
        default: break
        }
    }
}
