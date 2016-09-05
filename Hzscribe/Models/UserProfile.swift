//
//  UserProfile.swift
//  bose-scribe
//
//  Created by Colden Prime on 8/4/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import Foundation

class UserProfile {
    
    var fullName = ""
    var cohorts = [String]()
    var avatarURL: NSURL?
    
}

extension UserProfile {

    var nameComponents: [String] {
        return fullName.characters.split(" ", allowEmptySlices: false).map { String($0) }
    }
    
    var firstName: String? {
        return nameComponents.first
    }
    
    var lastName: String? {
        return nameComponents.count > 1 ? nameComponents.last! : nil
    }
    
    var firstInitial: Character? {
        guard let firstName = self.firstName else { return nil }
        return firstName[firstName.startIndex]
    }
    
    var lastInitial: Character? {
        guard let lastName = self.lastName else { return nil }
        return lastName[lastName.startIndex]
    }
    
    var initials: String? {
        guard let firstInitial = self.firstInitial else { return nil }
        var initials = String(firstInitial)
        if let lastInitial = self.lastInitial {
            initials.append(lastInitial)
        }
        return initials.uppercaseString
    }
    
    var nameAbridged: String? {
        guard let firstName = self.firstName else { return nil }
        var nameAbridged = firstName
        if let lastInitial = self.lastInitial {
            nameAbridged.appendContentsOf(" \(String(lastInitial)).")
        }
        return nameAbridged
    }

}
