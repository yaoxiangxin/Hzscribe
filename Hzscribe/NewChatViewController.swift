//
//  NewChatViewController.swift
//  bose-scribe
//
//  Created by Huanzhong Huang on 8/11/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import UIKit

class NewChatViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate {
    
    static let kCellIdentifier = "ContactCollectionViewCell"

    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var newChatLabel: UILabel!
    
    @IBOutlet var chatNameView: UIView!
    @IBOutlet var chatNameLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var bottomLayoutConstraint: NSLayoutConstraint!
    
    var contactDataSource: ContactDataSource!
    var defaultNamingDisabled = false
    
    // MARK: Action
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func clearTextField() {
        textField.text = nil
        textFieldTextDidChange()
    }
    
    // MARK: Helper
    func verifySubmitButtonState() {
        submitButton.enabled = textField.hasText() && collectionView.indexPathsForSelectedItems()?.count > 0
        submitButton.backgroundColor = submitButton.enabled ? .blackColor() : .bs_coolGrey()
    }
    
    func applyDefaultNaming() {
        defaultNamingDisabled = false
        
        guard let indexPaths = collectionView.indexPathsForSelectedItems() else { return }
        
        let names = indexPaths.flatMap { contactDataSource.userProfiles[$0.item].firstName }.sort()
        
        if names.count > 2 {
            textField.text = names[0..<names.indices.last!].joinWithSeparator(", ") + ", & \(names.last!)"
        } else if names.count > 1 {
            textField.text = names.joinWithSeparator(" & ")
        } else {
            textField.text = names.first
        }
    }
    
    func textFieldTextDidChange() { // NOT called when set programmatically
        defaultNamingDisabled = true
        verifySubmitButtonState()
    }
    
    func selectedItemsDidChange() {
        if !defaultNamingDisabled {
            applyDefaultNaming()
        }
        verifySubmitButtonState()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        if !textField.hasText() {
            applyDefaultNaming()
            verifySubmitButtonState()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedItemsDidChange()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        selectedItemsDidChange()
    }
    
    // MARK: Override
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textFieldTextDidChange), name: UITextFieldTextDidChangeNotification, object: nil)
        
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: UI Setup
    func setUpUI() {
        func setUpNewChatLabel() {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = 20.0
            newChatLabel.attributedText = NSAttributedString(
                string: "NEW CHAT",
                attributes: [
                    NSFontAttributeName: UIFont.bs_GothamBold(14.0),
                    NSForegroundColorAttributeName: UIColor.bs_black(),
                    NSKernAttributeName: 2.0,
                    NSParagraphStyleAttributeName: paragraphStyle
                ]
            )
        }
        
        func setUpChatNameView() {
            func setUpTextField() {
                let button = UIButton()
                button.addTarget(self, action: #selector(clearTextField), forControlEvents: .TouchUpInside)
                
                let image = UIImage(named: "bTNClear")!
                let (xInset, yInset) = (22 - image.size.width / 2, 22 - image.size.height / 2)
                button.setImage(image, forState: .Normal)
                button.contentEdgeInsets = UIEdgeInsetsMake(yInset, xInset, yInset, xInset)
                button.sizeToFit()
                
                textField.rightView = button
                textField.rightViewMode = .WhileEditing
                textField.clipsToBounds = false
                
                textField.delegate = self
                textField.borderStyle = .None
                textField.font = .bs_GothamMedium(14.0)
                textField.textColor = .bs_black()
            }
            
            chatNameView.addTopBorder(withColor: .bs_lightGrey(), andWidth: 1.0)
            chatNameView.addBottomBorder(withColor: .bs_lightGrey(), andWidth: 1.0)
            
            chatNameLabel.attributedText = NSAttributedString(
                string: "CHAT NAME",
                attributes: [
                    NSFontAttributeName: UIFont.bs_GothamMedium(12.0),
                    NSForegroundColorAttributeName: UIColor.bs_coolGrey(),
                    NSKernAttributeName: 0.8
                ]
            )
            
            setUpTextField()
        }
        
        func setUpCollectionView() {
            func setUpCollectionViewFlowLayout() {
                let unitWidth = UIScreen.mainScreen().bounds.width / 375
                collectionViewFlowLayout.minimumLineSpacing = unitWidth * 20
                collectionViewFlowLayout.minimumInteritemSpacing = unitWidth * 30
                
                let itemWidth = unitWidth * 90
                collectionViewFlowLayout.itemSize = CGSizeMake(itemWidth, itemWidth + 17)
                
                let (yInset, xInset) = (unitWidth * 13, unitWidth * 20)
                collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(yInset, xInset, yInset, xInset)
            }
            
            let nib = UINib(nibName: NewChatViewController.kCellIdentifier, bundle: nil)
            collectionView.registerNib(nib, forCellWithReuseIdentifier: NewChatViewController.kCellIdentifier)
            
            setUpCollectionViewFlowLayout()
            
            collectionView.dataSource = contactDataSource
            collectionView.delegate = self
            collectionView.allowsMultipleSelection = true
            
            collectionView.reloadData()
        }
        
        func setUpSubmitButton() {
            let title = NSAttributedString(
                string: "START CHAT",
                attributes: [
                    NSFontAttributeName: UIFont.bs_GothamMedium(13.0),
                    NSForegroundColorAttributeName: UIColor.bs_white(),
                    NSKernAttributeName: 2.0
                ]
            )
            submitButton.setAttributedTitle(title, forState: .Normal)
            submitButton.setAttributedTitle(title, forState: .Disabled)
            submitButton.backgroundColor = .bs_coolGrey()
            submitButton.enabled = false
        }
        
        setUpNewChatLabel()
        setUpChatNameView()
        setUpCollectionView()
        setUpSubmitButton()
    }
    
    // MARK: Managing keyboard
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let kbSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size {
            bottomLayoutConstraint.constant = kbSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        bottomLayoutConstraint.constant = 0.0
    }
    
}
