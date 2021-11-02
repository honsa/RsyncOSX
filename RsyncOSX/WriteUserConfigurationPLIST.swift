//
//  WriteUserConfigurationPLIST.swift
//  RsyncUI
//
//  Created by Thomas Evensen on 17/05/2021.
//
// swiftlint:disable line_length function_body_length cyclomatic_complexity trailing_comma

import Foundation

final class WriteUserConfigurationPLIST: NamesandPaths {
    private func convertuserconfiguration() -> [NSMutableDictionary] {
        var version3Rsync: Int?
        var detailedlogging: Int?
        var minimumlogging: Int?
        var fulllogging: Int?
        var marknumberofdayssince: String?
        var haltonerror: Int?
        var monitornetworkconnection: Int?
        var array = [NSMutableDictionary]()

        if SharedReference.shared.rsyncversion3 {
            version3Rsync = 1
        } else {
            version3Rsync = 0
        }
        if SharedReference.shared.detailedlogging {
            detailedlogging = 1
        } else {
            detailedlogging = 0
        }
        if SharedReference.shared.minimumlogging {
            minimumlogging = 1
        } else {
            minimumlogging = 0
        }
        if SharedReference.shared.fulllogging {
            fulllogging = 1
        } else {
            fulllogging = 0
        }
        if SharedReference.shared.haltonerror {
            haltonerror = 1
        } else {
            haltonerror = 0
        }
        if SharedReference.shared.monitornetworkconnection {
            monitornetworkconnection = 1
        } else {
            monitornetworkconnection = 0
        }
        marknumberofdayssince = String(SharedReference.shared.marknumberofdayssince)
        let dict: NSMutableDictionary = [
            DictionaryStrings.version3Rsync.rawValue: version3Rsync ?? 0 as Int,
            DictionaryStrings.detailedlogging.rawValue: detailedlogging ?? 0 as Int,
            DictionaryStrings.minimumlogging.rawValue: minimumlogging ?? 0 as Int,
            DictionaryStrings.fulllogging.rawValue: fulllogging ?? 0 as Int,
            DictionaryStrings.marknumberofdayssince.rawValue: marknumberofdayssince ?? "5.0",
            DictionaryStrings.haltonerror.rawValue: haltonerror ?? 0 as Int,
            DictionaryStrings.monitornetworkconnection.rawValue: monitornetworkconnection ?? 0 as Int,
        ]
        if let rsyncpath = SharedReference.shared.localrsyncpath {
            dict.setObject(rsyncpath, forKey: DictionaryStrings.rsyncPath.rawValue as NSCopying)
        }
        if let restorepath = SharedReference.shared.temporarypathforrestore {
            dict.setObject(restorepath, forKey: DictionaryStrings.restorePath.rawValue as NSCopying)
        } else {
            dict.setObject("", forKey: DictionaryStrings.restorePath.rawValue as NSCopying)
        }
        if let pathrsyncosx = SharedReference.shared.pathrsyncosx {
            if pathrsyncosx.isEmpty == false {
                dict.setObject(pathrsyncosx, forKey: DictionaryStrings.pathrsyncosx.rawValue as NSCopying)
            }
        }
        if let pathrsyncosxsched = SharedReference.shared.pathrsyncosxsched {
            if pathrsyncosxsched.isEmpty == false {
                dict.setObject(pathrsyncosxsched, forKey: DictionaryStrings.pathrsyncosxsched.rawValue as NSCopying)
            }
        }
        if let environment = SharedReference.shared.environment {
            dict.setObject(environment, forKey: DictionaryStrings.environment.rawValue as NSCopying)
        }
        if let environmentvalue = SharedReference.shared.environmentvalue {
            dict.setObject(environmentvalue, forKey: DictionaryStrings.environmentvalue.rawValue as NSCopying)
        }
        if let sshkeypathandidentityfile = SharedReference.shared.sshkeypathandidentityfile {
            dict.setObject(sshkeypathandidentityfile, forKey: DictionaryStrings.sshkeypathandidentityfile.rawValue as NSCopying)
        }
        if let sshport = SharedReference.shared.sshport {
            dict.setObject(sshport, forKey: DictionaryStrings.sshport.rawValue as NSCopying)
        }
        array.append(dict)
        return array
    }

    // Function for write data to persistent store
    @discardableResult
    func writeNSDictionaryToPersistentStorage(_ array: [NSDictionary]) -> Bool {
        let dictionary = NSDictionary(object: array, forKey: SharedReference.shared.userconfigkey as NSCopying)
        if let path = fullpathmacserial {
            let write = dictionary.write(toFile: path + SharedReference.shared.userconfigplist, atomically: true)
            if write && SharedReference.shared.menuappisrunning {
                Notifications().showNotification("Sending reload message to menu app")
                DistributedNotificationCenter.default().postNotificationName(NSNotification.Name("no.blogspot.RsyncOSX.reload"), object: nil, deliverImmediately: true)
            }
            return write
        }
        return false
    }

    @discardableResult
    init() {
        super.init(.configurations)
        let userconfig = convertuserconfiguration()
        writeNSDictionaryToPersistentStorage(userconfig)
    }
}
