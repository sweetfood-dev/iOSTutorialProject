//
//  AppDelegate.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("applicationDidFinishLaunching")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "AuteursBackground")
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGray2
        ]
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGray2
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

