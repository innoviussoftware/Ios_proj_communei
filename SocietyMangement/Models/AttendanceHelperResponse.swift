//
//  AttendanceHelperResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 06/01/21.
//  Copyright © 2021 MacMini. All rights reserved.
//

import Foundation


// MARK: - AttendanceHelperResponse
struct AttendanceHelperResponse: Codable {
    let data: AttendanceSheet?
    let status: Int?
    let message: String?
}

// MARK: - AttendanceSheet
struct AttendanceSheet: Codable {
    let totalDays, presentDays: Int?
    let attendanceData: [AttendanceDatum]?

    enum CodingKeys: String, CodingKey {
        case totalDays = "TotalDays"
        case presentDays = "PresentDays"
        case attendanceData = "AttendanceData"
    }
}

// MARK: - AttendanceDatum
struct AttendanceDatum: Codable {
    let daysAttended: String?
    let isPresent: Int?

    enum CodingKeys: String, CodingKey {
        case daysAttended = "DaysAttended"
        case isPresent = "IsPresent"
    }
}
