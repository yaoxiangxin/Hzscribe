//
//  ContactStore.swift
//  bose-scribe
//
//  Created by Huanzhong Huang on 8/11/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import Intrepid

class ContactStore {

    static let userProfiles = [
        "Joe Geiger", "Gustavo", "Cara Quigley",
        "Colden Prime", "Alan Scarpa", "Huan",
        "Radhika Koyowala", "Xan", "Tom O'Malley",
        "Andrea", "Ying Quan Tan", "Harold Sipe",
        "Count Dracula"
    ].map { (fullName: String) -> UserProfile in
        let userProfile = UserProfile()
        userProfile.fullName = fullName
        userProfile.cohorts = ["foo"]
        userProfile.avatarURL = NSURL(string: "https://unsplash.it/200/?random")
        return userProfile
    }
    
    static func downloadAllCohortProfiles(completion: Result<[UserProfile]> -> Void) {
        completion(.Success(userProfiles))
    }

}
