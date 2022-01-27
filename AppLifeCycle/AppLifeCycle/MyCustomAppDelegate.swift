//
//  MyCustomAppDelegate.swift
//  AppLifeCycle
//
//  Created by todoc on 2022/01/27.
//
import UIKit

// This is example if we would like to have Delegate what handle Push Notification registration and push messages
class MyCustomAppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Init some Manager, Service...
        print("🔴 MyCustomAppDelegate \(#function)")
        
        registerForPushNotifications()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("🔴 MyCustomAppDelegate \(#function)")
    }
    
    // MARK: - Notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("🔴 MyCustomAppDelegate \(#function)")
    }
}

extension MyCustomAppDelegate {
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
                print("Permission granted: \(granted)")
            }
    }
}
