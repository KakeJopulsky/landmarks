//
//  ProfileTest.swift
//  Landmarks
//
//  Created by Jake Kopulsky on 11/4/21.
//

import Foundation

class ProfileTest: ObservableObject {
    @Published var email: String
    @Published var username: String = ""
    @Published var prefersNotifications = true
    @Published var seasonalPhoto = Season.winter
    @Published var goalDate = Date()
    @Published var favoriteLandmarks = [String: String]()
    
    
    internal init(email: String, username: String) {
        self.email = email
        self.username = username
    }
//    public init(email: String, username: ) {
//        $email: email
//    }

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
    
}
