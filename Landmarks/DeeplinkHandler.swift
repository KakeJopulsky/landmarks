//
//  DeeplinkHandler.swift
//  Landmarks
//
//  Created by Jake Kopulsky on 11/2/21.
//

import Foundation

struct DeepLinkHandler {
    static func handle(url: URL) -> Bool {
        if let deeplink = Deeplink.from(url: url) {
            show(deeplink: deeplink)
            return true
        } else {
            return false
        }
    }
    
    private static func show(deeplink: Deeplink) {
        print ("SHOWING DEEP LINK")
    }
    
    // This enum helps with parsing of Deeplinks.
    // Given a URL this enum will return a Deeplink.
    // The deep link comes in as http://domain.com/../mocha
    private enum Deeplink {
        case mocha
        case latte
        case cappuccino
        case black
        
        static func from(url: URL) -> Deeplink? {
            let page = url.lastPathComponent.lowercased()
            switch page {
            case "mocha":
                return .mocha
            case "latte":
                return .latte
            case "cappuccino":
                return .cappuccino
            case "black":
                return .black
            default:
                return nil
            }
        }
    }
}
