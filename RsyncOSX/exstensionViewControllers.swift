//
//  exstensionViewControllers.swift
//  RsyncOSX
//
//  Created by Thomas Evensen on 04/12/2020.
//  Copyright © 2020 Thomas Evensen. All rights reserved.
//

import Cocoa
import Foundation

extension ViewControllerSideBar {

    // Toolbar -  Find tasks and Execute backup
    @IBAction func automaticbackup(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        presentAsSheet(viewControllerEstimating!)
    }

    // Toolbar - Estimate and Quickbackup
    @IBAction func totinfo(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        globalMainQueue.async { () -> Void in
            self.presentAsSheet(self.viewControllerRemoteInfo!)
        }
    }

    // Toolbar - Userconfiguration button
    @IBAction func userconfiguration(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        presentAsModalWindow(viewControllerUserconfiguration!)
    }

    // Toolbar - All ouput
    @IBAction func alloutput(_: NSButton) {
        presentAsModalWindow(viewControllerAllOutput!)
    }
}

extension ViewControllerNewConfigurations {

    // Toolbar -  Find tasks and Execute backup
    @IBAction func automaticbackup(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        presentAsSheet(viewControllerEstimating!)
    }

    // Toolbar - Estimate and Quickbackup
    @IBAction func totinfo(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        globalMainQueue.async { () -> Void in
            self.presentAsSheet(self.viewControllerRemoteInfo!)
        }
    }

    // Toolbar - Userconfiguration button
    @IBAction func userconfiguration(_: NSButton) {
        guard SharedReference.shared.process == nil else { return }
        presentAsModalWindow(viewControllerUserconfiguration!)
    }

    // Toolbar - All ouput
    @IBAction func alloutput(_: NSButton) {
        presentAsModalWindow(viewControllerAllOutput!)
    }
}

extension ViewControllerSchedule {

    // Toolbar -  Find tasks and Execute backup
    @IBAction func automaticbackup(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        presentAsSheet(viewControllerEstimating!)
    }

    // Toolbar - Estimate and Quickbackup
    @IBAction func totinfo(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        globalMainQueue.async { () -> Void in
            self.presentAsSheet(self.viewControllerRemoteInfo!)
        }
    }

    // Toolbar - Userconfiguration button
    @IBAction func userconfiguration(_: NSButton) {
        guard SharedReference.shared.process == nil else { return }
        presentAsModalWindow(viewControllerUserconfiguration!)
    }

    // Toolbar - All ouput
    @IBAction func alloutput(_: NSButton) {
        presentAsModalWindow(viewControllerAllOutput!)
    }
}

extension ViewControllerSnapshots {
   
    // Toolbar -  Find tasks and Execute backup
    @IBAction func automaticbackup(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        presentAsSheet(viewControllerEstimating!)
    }

    // Toolbar - Estimate and Quickbackup
    @IBAction func totinfo(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        globalMainQueue.async { () -> Void in
            self.presentAsSheet(self.viewControllerRemoteInfo!)
        }
    }

    // Toolbar - Userconfiguration button
    @IBAction func userconfiguration(_: NSButton) {
        guard SharedReference.shared.process == nil else { return }
        presentAsModalWindow(viewControllerUserconfiguration!)
    }

    // Toolbar - All ouput
    @IBAction func alloutput(_: NSButton) {
        presentAsModalWindow(viewControllerAllOutput!)
    }

    // Toolbar -  abort Snapshots
    @IBAction func abort(_: NSButton) {
        info.stringValue = Infosnapshots().info(num: 2)
        snapshotlogsandcatalogs?.snapshotcatalogstodelete = nil
    }
}

extension ViewControllerRestore {

    // Toolbar -  Find tasks and Execute backup
    @IBAction func automaticbackup(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        presentAsSheet(viewControllerEstimating!)
    }

    // Toolbar - Estimate and Quickbackup
    @IBAction func totinfo(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        globalMainQueue.async { () -> Void in
            self.presentAsSheet(self.viewControllerRemoteInfo!)
        }
    }

    // Toolbar - Userconfiguration button
    @IBAction func userconfiguration(_: NSButton) {
        guard SharedReference.shared.process == nil else { return }
        presentAsModalWindow(viewControllerUserconfiguration!)
    }

    // Toolbar - All ouput
    @IBAction func alloutput(_: NSButton) {
        presentAsModalWindow(viewControllerAllOutput!)
    }
}

extension ViewControllerLoggData {

    // Toolbar -  Find tasks and Execute backup
    @IBAction func automaticbackup(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        presentAsSheet(viewControllerEstimating!)
    }

    // Toolbar - Estimate and Quickbackup
    @IBAction func totinfo(_: NSButton) {
        guard checkforrsync() == false else { return }
        guard SharedReference.shared.process == nil else { return }
        globalMainQueue.async { () -> Void in
            self.presentAsSheet(self.viewControllerRemoteInfo!)
        }
    }

    // Toolbar - Userconfiguration button
    @IBAction func userconfiguration(_: NSButton) {
        guard SharedReference.shared.process == nil else { return }
        presentAsModalWindow(viewControllerUserconfiguration!)
    }

    // Toolbar - All ouput
    @IBAction func alloutput(_: NSButton) {
        presentAsModalWindow(viewControllerAllOutput!)
    }
}

extension ViewControllerSsh {

    // Toolbar - Userconfiguration button
    @IBAction func userconfiguration(_: NSButton) {
        guard SharedReference.shared.process == nil else { return }
        presentAsModalWindow(viewControllerUserconfiguration!)
    }
}
