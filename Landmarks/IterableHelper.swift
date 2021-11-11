//
//  IterableHelper.swift
//  Landmarks
//
//  Created by Jake Kopulsky on 11/2/21.
//

import Foundation
import UIKit
import UserNotifications

import IterableSDK
import Segment

/// Utility class to encapsulate Iterable specific code.
class IterableHelper {
    private static let apiKey = "2836b004b3454747bd36dbf2a3e41e67"
    public static let segmentKey = "BqksShoELFiXCWHu4BURtcCV29OdyF5C"
    var segment: Analytics?
    public static let shared = IterableHelper()
    
    static func initialize(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        let config = IterableConfig()
        // urlDelegate and customActionDelegate must be strong references
        // otherwise they will be deallocated
        config.urlDelegate = urlDelegate
        config.customActionDelegate = customActionDelegate
        IterableAPI.initialize(apiKey: apiKey,
                               launchOptions: launchOptions,
                               config: config)
        
        let configuration = AnalyticsConfiguration(writeKey: segmentKey)
        configuration.trackApplicationLifecycleEvents = true // Enable this to record certain application events automatically!
        configuration.recordScreenViews = false // Enable this to record screen views automatically!
        configuration.flushAt = 1  // Number of events that should queue before flushing
        Analytics.setup(with: configuration)
    }

    static func login(email: String, username: String) {
        IterableAPI.email = email
        var dataFields = [String: Any]()
        dataFields["username"] = username
        IterableAPI.updateUser(dataFields, mergeNestedObjects: true, onSuccess: myUserUpdateSuccessHandler, onFailure: myUserUpdateFailureHandler)
    }
    
    static func updateUserProfile(dataFields: [String: Any]) {
        IterableAPI.updateUser(dataFields, mergeNestedObjects: true, onSuccess: myUserUpdateSuccessHandler, onFailure: myUserUpdateFailureHandler)
    }
        
    static func iterableTrackEvent(eventName: String, dataFields: [String: Any]) {
        IterableAPI.track(
            event: eventName,
            dataFields: dataFields
        )
    }
    
    static func segmentTrackEvent(eventName: String, properties: [String: Any]) {
        Analytics.shared().track(eventName, properties: properties)
    }
    
    static func segmentIdentify(userId: String, traits: [String: Any]?) {
        Analytics.shared().identify(userId, traits: traits)
    }
    
    static func myUserUpdateSuccessHandler(data:[AnyHashable:Any]?) -> () {
        // success
        print("sent to Iterable success")
    }

    static func myUserUpdateFailureHandler(reason:String?, data:Data?) -> () {
        // failure
        print("sent to Iterable failure")
    }
    
    static func logout() {
        IterableAPI.email = nil
    }
    
    /// This is needed to hookup track push opens.
    /// This will also setup url handler, custom action handler to work with IterableSDK
    static func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        IterableAppIntegration.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
    
    /// This is needed for silent push
    static func application(_ application: UIApplication,
                            didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                            fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    /// Pass deeplinks to iterable
    static func handle(universalLink url: URL) -> Bool {
        IterableAPI.handle(universalLink: url)
    }
    
    /// Pass the token to Iterable
    static func register(token: Data) {
        IterableAPI.register(token: token)
    }
    
    private static var urlDelegate = URLDelegate()
    private static var customActionDelegate = CustomActionDelegate()
}

class URLDelegate{}

extension URLDelegate: IterableURLDelegate {
    func handle(iterableURL url: URL, inContext context: IterableActionContext) -> Bool {
        DeepLinkHandler.handle(url: url)
    }
}

class CustomActionDelegate{}

extension CustomActionDelegate: IterableCustomActionDelegate {
    func handle(iterableCustomAction action: IterableAction, inContext context: IterableActionContext) -> Bool {
        true
    }
}
