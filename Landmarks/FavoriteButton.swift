//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Jake Kopulsky on 11/1/21.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    @Binding var selectedLandmarkName: String

    var body: some View {
        Button(action: {
            isSet.toggle()
            if (isSet) {
                IterableHelper.iterableTrackEvent(eventName: "favorited_landmark", dataFields: ["landmark" : selectedLandmarkName])
                IterableHelper.segmentTrackEvent(eventName: "favorited_landmark", properties: ["landmark" : selectedLandmarkName])
            }
        }) {
            Image(systemName: isSet ? "star.fill" : "star")
                .foregroundColor(isSet ? Color.yellow : Color.gray)
        }
    }
}

//struct FavoriteButton_Previews: PreviewProvider {
////    var selectedLandmark
//    static var previews: some View {
//        FavoriteButton(isSet: .constant(true), selectedLandmark: <#T##ModelData#>)
//    }
//}
