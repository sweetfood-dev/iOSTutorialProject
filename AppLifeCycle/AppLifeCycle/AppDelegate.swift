//
//  AppDelegate.swift
//  AppLifeCycle
//
//  Created by todoc on 2022/01/27.
//

import UIKit
import UserNotifications

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Variables
    var window: UIWindow?
    private var startScreen: UIViewController = ViewController()
    // 여러 Logic을 분리하게 될 수도 있음.
    // 예) PushNotification, Location, 3rd party framework등에서 appdelegate 메소드 호출이 필요 할때, 한곳에 다 몰아 넣기 보다는 분리하여 관리, MyCustomAppDelegate 참고
    private var appDelegates = [UIApplicationDelegate]()
    
    // MARK: - App Lifecycle
    
    override init() {
        super.init()
        print("🔵 AppDelegate \(#function)")
        // CustomAppDelegate List ( Location, Notification, Firebase 등등 써드파티 )
        appDelegates = [MyCustomAppDelegate()]
    }
    
    
    // Launch 프로세스가 실행 되고, 스토리보드 / nib 파일이 로드 되었지만 state 복원은 이루어 지지 않음
    // inactive 상태이기 때문에 화면이 올라오진 않음
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
        appDelegates.forEach { _ = $0.application?(application,
                                                   willFinishLaunchingWithOptions: launchOptions) }
        return true
    }
    
    // window와 기타 UI 요소가 나타나기 전 Launch 프로세스가 거의 완료되는 시점에 OS에 의해 호출
    // 백그라운드 프로세스에서 OS에 의해서 호출도 가능
    // 따라서 이 시점 app의 state는 active / inactive일 수 있음
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
        
        appDelegates.forEach {
            _ = $0.application?(application,
                                didFinishLaunchingWithOptions: launchOptions)
        }
        
        window = UIWindow()
        window?.rootViewController = startScreen
        window?.makeKeyAndVisible()
        return true
    }
    
    // inactive -> active로 돌아올 때 호출
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
        appDelegates.forEach {
            _ = $0.applicationDidBecomeActive?(application)
        }
    }
    
    // 앱이 종료되기 직전 호출
    func applicationWillTerminate(_ application: UIApplication) {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    // 앱이 inactive가 되기 직전 호출
    func applicationWillResignActive(_ application: UIApplication) {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    // background로 진입하였을 때 호출
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
        
        application.beginBackgroundTask {
            print("Background time remaning: \(application.backgroundTimeRemaining)")
            application.endBackgroundTask(UIBackgroundTaskIdentifier.invalid)
        }
    }
    
    // Deprecated
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    // background -> active로 전환될 때 호출
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("🔵 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
}

// MARK: - Notification
extension AppDelegate {
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("🔵 AppDelegate \(#function)")
        appDelegates.forEach {
            _ = $0.application?(application,
                                didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("🔵 AppDelegate \(#function)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("🔵 AppDelegate \(#function)")
    }
}

// MARK: - Action
extension AppDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("🔵 AppDelegate \(#function)")
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print("🔵 AppDelegate \(#function)")
        return true
    }
}

// MARK: - Security
extension AppDelegate {
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        print("🔓 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        print("🔓 AppDelegate \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
}

// MARK: - Utility
extension AppDelegate {
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("🟠 AppDelegate \(#function)")
        // try to clean up as much memory as possible. next step is to terminate app
    }
    
    func applicationSignificantTimeChange(_ application: UIApplication) {
        print("🟠 AppDelegate \(#function)")
        // midnight, carrier time update, daylight savings time change
    }
}



// MARK: - Debug/Helper
extension UIApplication.State {
    func toString() -> String {
        switch self {
        case .active: return "active"
        case .inactive: return "inactive"
        case .background: return "background"
        default: return "none"
        }
    }
}
