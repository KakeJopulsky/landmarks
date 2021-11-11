//
//  Profile.swift
//  Landmarks
//
//  Created by Jake Kopulsky on 11/2/21.
//

import Foundation

struct Profile {
    var username: String = ""
    var email: String = ""
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    var favoriteLandmarks = [String: String]()
    var note: String = ""

    static let `default` = Profile(username: "default", email: "default@iterable.com")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}
