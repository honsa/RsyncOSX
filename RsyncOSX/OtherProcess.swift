//
//  OtherProcessCmdClosure.swift
//  RsyncOSX
//
//  Created by Thomas Evensen on 17/09/2020.
//  Copyright © 2020 Thomas Evensen. All rights reserved.
//

import Combine
import Foundation

final class OtherProcess {
    // Combine subscribers
    var subscriptons = Set<AnyCancellable>()
    // Process termination and filehandler closures
    var processtermination: () -> Void
    var filehandler: () -> Void
    // Command to be executed, normally rsync
    var command: String?
    // Arguments to command
    var arguments: [String]?
    // Enable and disable select profile
    weak var profilepopupDelegate: DisableEnablePopupSelectProfile?

    func executeProcess(outputprocess: OutputfromProcess?) {
        guard command != nil else { return }
        // Process
        let task = Process()
        // If self.command != nil either alternativ path for rsync or other command than rsync to be executed
        if let command = command {
            task.launchPath = command
        }
        task.arguments = arguments
        // If there are any Environmentvariables like
        // SSH_AUTH_SOCK": "/Users/user/.gnupg/S.gpg-agent.ssh"
        if let environment = Environment() {
            task.environment = environment.environment
        }
        // Pipe for reading output from Process
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        let outHandle = pipe.fileHandleForReading
        outHandle.waitForDataInBackgroundAndNotify()
        // Combine, subscribe to NSNotification.Name.NSFileHandleDataAvailable
        NotificationCenter.default.publisher(
            for: NSNotification.Name.NSFileHandleDataAvailable)
            .sink { _ in
                let data = outHandle.availableData
                if data.count > 0 {
                    if let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        outputprocess?.addlinefromoutput(str: str as String)
                        self.filehandler()
                    }
                    outHandle.waitForDataInBackgroundAndNotify()
                }
            }.store(in: &subscriptons)
        // Combine, subscribe to Process.didTerminateNotification
        NotificationCenter.default.publisher(
            for: Process.didTerminateNotification)
            .debounce(for: .milliseconds(500), scheduler: globalMainQueue)
            .sink { [self] _ in
                self.processtermination()
                // Release Combine subscribers
                subscriptons.removeAll()
            }.store(in: &subscriptons)
        profilepopupDelegate?.disableselectpopupprofile()
        SharedReference.shared.process = task
        do {
            try task.run()
        } catch let e {
            let error = e as NSError
            let outputprocess = OutputfromProcess()
            outputprocess.addlinefromoutput(str: error.description)
            _ = Logfile(TrimTwo(outputprocess.getOutput() ?? []).trimmeddata, error: false)
        }
    }

    init(command: String?,
         arguments: [String]?,
         processtermination: @escaping () -> Void,
         filehandler: @escaping () -> Void)
    {
        self.command = command
        self.arguments = arguments
        self.processtermination = processtermination
        self.filehandler = filehandler
        profilepopupDelegate = SharedReference.shared.getvcref(viewcontroller: .vctabmain) as? ViewControllerMain
    }

    deinit {
        SharedReference.shared.process = nil
        // Enable select profile
        self.profilepopupDelegate?.enableselectpopupprofile()
    }
}
