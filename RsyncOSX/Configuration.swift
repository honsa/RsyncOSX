//
//  ConfigurationsJSON.swift
//  RsyncOSX
//
//  Created by Thomas Evensen on 26/05/2021.
//  Copyright © 2021 Thomas Evensen. All rights reserved.
//

//
//  Created by Thomas Evensen on 08/02/16.
//  Copyright © 2016 Thomas Evensen. All rights reserved.
//

import Foundation

enum NumDayofweek: Int {
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    case Sunday = 1
}

enum StringDayofweek: String, CaseIterable, Identifiable, CustomStringConvertible {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday

    var id: String { rawValue }
    var description: String { rawValue.localizedLowercase }
}

enum PlanSnapshots: String, CaseIterable, CustomStringConvertible {
    case Every // keepallselcteddayofweek
    case Last // islastSelectedDayinMonth

    var description: String { rawValue.localizedLowercase }
}

struct Configuration: Codable {
    var hiddenID: Int
    var task: String
    var localCatalog: String
    var offsiteCatalog: String
    var offsiteUsername: String
    var parameter1: String
    var parameter2: String
    var parameter3: String
    var parameter4: String
    var parameter5: String
    var parameter6: String
    var offsiteServer: String
    var backupID: String
    var dateRun: String?
    var snapshotnum: Int?
    // parameters choosed by user
    var parameter8: String?
    var parameter9: String?
    var parameter10: String?
    var parameter11: String?
    var parameter12: String?
    var parameter13: String?
    var parameter14: String?
    var rsyncdaemon: Int?
    // SSH parameters
    var sshport: Int?
    var sshkeypathandidentityfile: String?
    // Calculated days since last backup
    var dayssincelastbackup: String?
    var markdays: Bool = false
    var profile: String?
    // Snapshots, day to save and last = 1 or every last=0
    var snapdayoffweek: String?
    var snaplast: Int?
    // Pre and post tasks
    var executepretask: Int?
    var pretask: String?
    var executeposttask: Int?
    var posttask: String?
    var haltshelltasksonerror: Int?

    var lastruninseconds: Double? {
        if let date = dateRun {
            let lastbackup = date.en_us_date_from_string()
            let seconds: TimeInterval = lastbackup.timeIntervalSinceNow
            return seconds * -1
        } else {
            return nil
        }
    }

    // Used when reading JSON data from store
    // see in ReadConfigurationJSON
    init(_ data: DecodeConfiguration) {
        backupID = data.backupID ?? ""
        hiddenID = data.hiddenID ?? -1
        localCatalog = data.localCatalog ?? ""
        offsiteCatalog = data.offsiteCatalog ?? ""
        offsiteServer = data.offsiteServer ?? ""
        offsiteUsername = data.offsiteUsername ?? ""
        parameter1 = data.parameter1 ?? ""
        parameter10 = data.parameter10
        parameter11 = data.parameter11
        parameter12 = data.parameter12
        parameter13 = data.parameter13
        parameter14 = data.parameter14
        parameter2 = data.parameter2 ?? ""
        parameter3 = data.parameter3 ?? ""
        parameter4 = data.parameter4 ?? ""
        parameter5 = data.parameter5 ?? ""
        parameter6 = data.parameter6 ?? ""
        parameter8 = data.parameter8
        parameter9 = data.parameter9
        rsyncdaemon = data.rsyncdaemon
        sshkeypathandidentityfile = data.sshkeypathandidentityfile
        sshport = data.sshport
        task = data.task ?? ""
        executepretask = data.executepretask
        pretask = data.pretask
        executeposttask = data.executeposttask
        posttask = data.posttask
        snapshotnum = data.snapshotnum
        haltshelltasksonerror = data.haltshelltasksonerror
        // For snapshots
        if let snapshotnum = data.snapshotnum {
            self.snapshotnum = snapshotnum
            snapdayoffweek = data.snapdayoffweek ?? StringDayofweek.Sunday.rawValue
            snaplast = data.snaplast ?? 1
        }
        // Last run of task
        if let dateRun = data.dateRun {
            self.dateRun = dateRun
            if let secondssince = lastruninseconds {
                dayssincelastbackup = String(format: "%.2f", secondssince / (60 * 60 * 24))
                if secondssince / (60 * 60 * 24) > SharedReference.shared.marknumberofdayssince {
                    markdays = true
                }
            }
        }
    }

    // Create an empty record with no values
    init() {
        hiddenID = -1
        task = ""
        localCatalog = ""
        offsiteCatalog = ""
        offsiteUsername = ""
        parameter1 = ""
        parameter2 = ""
        parameter3 = ""
        parameter4 = ""
        parameter5 = ""
        parameter6 = ""
        offsiteServer = ""
        backupID = ""
    }
}

extension Configuration: Hashable, Equatable {
    static func == (lhs: Configuration, rhs: Configuration) -> Bool {
        return lhs.localCatalog == rhs.localCatalog &&
            lhs.offsiteCatalog == rhs.offsiteCatalog &&
            lhs.offsiteUsername == rhs.offsiteUsername &&
            lhs.offsiteServer == rhs.offsiteServer &&
            lhs.hiddenID == rhs.hiddenID &&
            lhs.task == rhs.task &&
            lhs.parameter1 == rhs.parameter1 &&
            lhs.parameter2 == rhs.parameter2 &&
            lhs.parameter3 == rhs.parameter3 &&
            lhs.parameter4 == rhs.parameter4 &&
            lhs.parameter5 == rhs.parameter5 &&
            lhs.parameter6 == rhs.parameter6 &&
            lhs.parameter8 == rhs.parameter8 &&
            lhs.parameter9 == rhs.parameter9 &&
            lhs.parameter10 == rhs.parameter10 &&
            lhs.parameter11 == rhs.parameter11 &&
            lhs.parameter12 == rhs.parameter12 &&
            lhs.parameter13 == rhs.parameter13 &&
            lhs.parameter14 == rhs.parameter14 &&
            lhs.dateRun == rhs.dateRun
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(localCatalog)
        hasher.combine(offsiteUsername)
        hasher.combine(offsiteServer)
        hasher.combine(String(hiddenID))
        hasher.combine(task)
        hasher.combine(parameter1)
        hasher.combine(parameter2)
        hasher.combine(parameter3)
        hasher.combine(parameter4)
        hasher.combine(parameter5)
        hasher.combine(parameter6)
        hasher.combine(parameter8)
        hasher.combine(parameter9)
        hasher.combine(parameter10)
        hasher.combine(parameter11)
        hasher.combine(parameter12)
        hasher.combine(parameter13)
        hasher.combine(parameter14)
        hasher.combine(dateRun)
    }
}
