//
//  BookingsModel.swift
//  SocietyMangement
//
//  Created by Macmini on 10/11/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - BookingsList
struct BookingsList: Codable {
    let data: [BookingsListData]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct BookingsListData: Codable {
    let amenitiesBookingID, amenityID, bookingStatusID: Int?
    let bookingNotes: String?
    let amount: Int?
    let startDate, endDate, createdAt, amenityName: String?
    let bookingStatusName, createdBy: String?
    let attachments: [AttachmentArr]?

    enum CodingKeys: String, CodingKey {
        case amenitiesBookingID = "AmenitiesBookingID"
        case amenityID = "AmenityID"
        case bookingStatusID = "BookingStatusID"
        case bookingNotes = "BookingNotes"
        case amount = "Amount"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case createdAt = "CreatedAt"
        case amenityName = "AmenityName"
        case bookingStatusName = "BookingStatusName"
        case createdBy = "CreatedBy"
        case attachments = "Attachments"
    }
}

// MARK: - Attachment
struct AttachmentArr: Codable {
    let amenityID: Int?
    let attachment: String?

    enum CodingKeys: String, CodingKey {
        case amenityID = "AmenityID"
        case attachment = "Attachment"
    }
}
