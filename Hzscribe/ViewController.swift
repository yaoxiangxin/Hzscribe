//
//  ViewController.swift
//  Hzscribe
//
//  Created by Huanzhong Huang on 9/2/16.
//  Copyright © 2016 Huanzhong Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func newChat(sender: UIButton) {
        let contactDataSource = ContactDataSource()
        contactDataSource.reloadContactProfiles {
            let newChatViewController = NewChatViewController()
            newChatViewController.contactDataSource = contactDataSource
            self.presentViewController(newChatViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
