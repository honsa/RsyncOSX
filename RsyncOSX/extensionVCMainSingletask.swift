//
//  extensionVCMainSingletask.swift
//  RsyncOSX
//
//  Created by Thomas Evensen on 25/08/2019.
//  Copyright © 2019 Thomas Evensen. All rights reserved.
//
//  swiftlint:disable line_length

import Cocoa
import Foundation

extension ViewControllerMain: SingleTaskProcess {
    func presentViewProgress() {
        globalMainQueue.async { () in
            self.presentAsSheet(self.viewControllerProgress!)
        }
    }

    func presentViewInformation(outputprocess: OutputfromProcess?) {
        self.outputprocess = outputprocess
        if appendnow() {
            globalMainQueue.async { () in
                self.mainTableView.reloadData()
            }
        } else {
            globalMainQueue.async { () in
                self.presentAsSheet(self.viewControllerInformation!)
            }
        }
    }

    func terminateProgressProcess() {
        weak var localprocessupdateDelegate: UpdateProgress?
        localprocessupdateDelegate = SharedReference.shared.getvcref(viewcontroller: .vcprogressview) as? ViewControllerProgressProcess
        localprocessupdateDelegate?.processTermination()
    }
}
