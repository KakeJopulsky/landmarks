//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Jake Kopulsky on 11/1/21.
//

import SwiftUI
import Segment

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    @UIApplicationDelegateAdaptor
    private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(user: Profile(username: "", email: ""))
                .environmentObject(modelData)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // Ask for permission for notifications and setup delegate
    NotificationsHelper.shared.setupNotifications()
    
    IterableHelper.initialize(launchOptions: launchOptions)

    return true
  }
  
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    IterableHelper.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
  }
  
  func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    IterableHelper.register(token: deviceToken)
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register token: \(error.localizedDescription)")
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    guard let url = userActivity.webpageURL else {
      return false
    }
    
    return IterableHelper.handle(universalLink: url)
  }
}
