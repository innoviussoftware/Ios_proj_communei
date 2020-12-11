//
//  AddBookingNowResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 11/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation

// MARK: - AddBookingNowResponse
struct AddBookingNowResponse: Codable {
    let data: AddBookingNow?
    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct AddBookingNow: Codable {
    let amenitiesBookingID, amenityID, userID, bookingStatusID: Int?
    let bookingNotes: String?
    let amount: Int?
    let startDate, endDate, createdAt: String?
   // let lastUpdateBy, lastUpdatedAt, deletedBy, deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case amenitiesBookingID = "AmenitiesBookingID"
        case amenityID = "AmenityID"
        case userID = "UserID"
        case bookingStatusID = "BookingStatusID"
        case bookingNotes = "BookingNotes"
        case amount = "Amount"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case createdAt = "CreatedAt"
       /* case lastUpdateBy = "LastUpdateBy"
        case lastUpdatedAt = "LastUpdatedAt"
        case deletedBy = "DeletedBy"
        case deletedAt = "DeletedAt" */
    }
}
