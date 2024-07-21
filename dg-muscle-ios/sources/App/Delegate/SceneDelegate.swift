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
import DataLayer

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            handleShortCutItem(item: shortcutItem)
        }
        
        if let urlContext = connectionOptions.urlContexts.first {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.handleURL(url: urlContext.url)
            }
        }
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        handleShortCutItem(item: shortcutItem)
        completionHandler(true)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.map({ $0.url }).first else { return }
        handleURL(url: url)
    }
    
    private func handleShortCutItem(item: UIApplicationShortcutItem) {
        if let url = URL(string: item.type) {
            handleURL(url: url)
        }
    }
    
    private func handleURL(url: URL) {
        if UserRepositoryImpl.shared.isReady == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.handleURL(url: url)
            }
            return
        }
        guard let scheme = url.scheme, let host = url.host() else { return }
        guard scheme == "dgmuscle" else { return }
        
        switch host {
        case "pop":
            coordinator?.pop()
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
            coordinator?.friend.friendMainView(anchor: anchor)
        case "friendhistory":
            guard let friendId = URLManager.shared.getParameter(url: url, name: "id") else { return }
            coordinator?.friend.friendHistory(friendId: friendId)
        case "profile":
            coordinator?.my.profile()
        case "exercisemanage":
            coordinator?.exercise.exerciseManage()
        case "heatmapcolorselect":
            coordinator?.history.heatMapColorSelectView()
        case "history":
            let historyId = URLManager.shared.getParameter(url: url, name: "id")
            coordinator?.history.historyFormStep1(historyId: historyId)
        case "friendhistorydetail":
            guard let friendId = URLManager.shared.getParameter(url: url, name: "friend_id") else { return }
            guard let historyId = URLManager.shared.getParameter(url: url, name: "history_id") else { return }
            coordinator?.friend.friendHistoryDetail(friendId: friendId, historyId: historyId)
        case "deleteaccountconfirm":
            coordinator?.my.deleteAccountConfirm()
        case "logs":
            coordinator?.my.logs()
        case "setrundistance":
            let distance = URLManager.shared.getParameter(url: url, name: "distance") ?? ""
            coordinator?.history.setDistance(distance: Double(distance) ?? 0)
        case "setrunduration":
            let duration = URLManager.shared.getParameter(url: url, name: "duration") ?? ""
            coordinator?.history.setDuration(duration: Int(duration) ?? 0)
        case "datetoselecthistory":
            coordinator?.history.dateToSelectHistory()
        case "managetraingmode":
            coordinator?.history.manageTrainigMode()
        case "rapidsearchtype":
            coordinator?.rapid.rapidSearchTypeList()
        case "rapid_search_by_part":
            coordinator?.rapid.rapidSearchByBodyPart()
        default: break
        }
    }
}
