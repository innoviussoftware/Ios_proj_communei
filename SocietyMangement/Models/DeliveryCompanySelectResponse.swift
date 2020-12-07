//
//  DeliveryCompanySelectResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 07/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - DeliveryCompanySelectResponse

struct DeliveryCompanySelectResponse: Codable {
    let data: [DeliveryCompanySelect]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct DeliveryCompanySelect: Codable {
    let vendorID: Int?
    let companyName: String?
    let companyLogoURL: String?
    let visitorEntryTypeID, isActive, isPublic: Int?
    let propertyID: Int?

    enum CodingKeys: String, CodingKey {
        case vendorID = "VendorID"
        case companyName = "CompanyName"
        case companyLogoURL = "CompanyLogoURL"
        case visitorEntryTypeID = "VisitorEntryTypeID"
        case isActive = "IsActive"
        case isPublic = "IsPublic"
        case propertyID = "PropertyID"
    }
}
