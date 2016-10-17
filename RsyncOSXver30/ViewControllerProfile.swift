//
//  ViewControllerProfile.swift
//  RsyncOSX
//
//  Created by Thomas Evensen on 17/10/2016.
//  Copyright © 2016 Thomas Evensen. All rights reserved.
//

import Foundation
import Cocoa

protocol Profiles : class {
    func newProfile()
}


class ViewControllerProfile : NSViewController {

    // Dismisser
    weak var dismiss_delegate:DismissViewController?
    // new Profile
    weak var newProfile_delegate:Profiles?
    
    @IBOutlet weak var delete: NSButton!
    @IBOutlet weak var new: NSButton!
    @IBOutlet weak var select: NSButton!
    @IBOutlet weak var Default: NSButton!
    
    @IBAction func radioButtons(_ sender: NSButton) {
        if let pvc = self.presenting as? ViewControllertabMain {
            self.newProfile_delegate = pvc
        }
        if (self.delete.state == 1) {
            
        } else if (self.new.state == 1) {
            
        } else if (self.select.state == 1) {
            SharingManagerConfiguration.sharedInstance.setProfile(profile: "test")
            newProfile_delegate?.newProfile()
            self.dismiss_delegate?.dismiss_view(viewcontroller: self)
        } else if (self.Default.state == 1) {
            SharingManagerConfiguration.sharedInstance.setProfile(profile: nil)
            newProfile_delegate?.newProfile()
            self.dismiss_delegate?.dismiss_view(viewcontroller: self)
        }
    }
    
    @IBAction func close(_ sender: NSButton) {
        self.dismiss_delegate?.dismiss_view(viewcontroller: self)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Dismisser is root controller
        if let pvc2 = self.presenting as? ViewControllertabMain {
            self.dismiss_delegate = pvc2
        } else if let pvc2 = self.presenting as? ViewControllertabSchedule{
            self.dismiss_delegate = pvc2
        } else if let pvc2 = self.presenting as? ViewControllerNewConfigurations {
            self.dismiss_delegate = pvc2
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }

}
