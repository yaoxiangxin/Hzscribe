//
//  ContactDataSource.swift
//  bose-scribe
//
//  Created by Huanzhong Huang on 8/18/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import AlamofireImage

class ContactDataSource: NSObject {

    var userProfiles = [UserProfile]()
    
    func reloadContactProfiles(withCompletion completion: (() -> Void)? = nil) {
        ContactStore.downloadAllCohortProfiles { result in
            switch result {
            case let .Success(userProfiles):
                self.userProfiles = userProfiles
            case .Failure(_):
                break
            }
            completion?()
        }
    }

}

extension ContactDataSource: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userProfiles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NewChatViewController.kCellIdentifier, forIndexPath: indexPath) as! ContactCollectionViewCell
        
        if cell.nameLabel.text == "Label" { // one-time configuration for new cell
            let radius = cell.bounds.width / 90 * 42
            let width = radius * 2
            let size = CGSizeMake(width, width)
            
            cell.avatarImageView.bounds.size = size
            cell.avatarImageView.layer.cornerRadius = radius
            cell.avatarImageView.clipsToBounds = true
            
            cell.initialLabel.bounds.size = size
            cell.initialLabel.layer.cornerRadius = radius
            cell.initialLabel.clipsToBounds = true
            cell.initialLabel.backgroundColor = .bs_black()
            cell.initialLabel.font = .bs_GothamMedium(36.0)
            cell.initialLabel.textColor = .bs_white()
            
            cell.nameLabel.font = .bs_GothamBook(12.0)
            cell.nameLabel.textColor = .bs_black()
        }
        
        let userProfile = userProfiles[indexPath.item]
        
        if arc4random_uniform(2) == 0 {
            cell.initialLabel.hidden = false
            cell.initialLabel.text = userProfile.initials
        } else {
            cell.initialLabel.hidden = true
            cell.avatarImageView.af_setImageWithURL(userProfile.avatarURL!)
        }
        cell.avatarImageView.hidden = !cell.initialLabel.hidden
        
        cell.nameLabel.text = userProfile.nameAbridged
        
        return cell
    }
    
}
