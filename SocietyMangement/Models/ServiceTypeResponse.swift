//
//  ServiceTypeResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 18/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - ServiceTypeResponse
struct ServiceTypeResponse: Codable {
    let data: [ServiceType]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct ServiceType: Codable {
    let vendorServiceTypeID: Int?
    let type: String?
    let serviceIconURL: String?
    let avilableInternal: Int?

    enum CodingKeys: String, CodingKey {
        case vendorServiceTypeID = "VendorServiceTypeID"
        case type = "Type"
        case serviceIconURL = "ServiceIconURL"
        case avilableInternal = "AvilableInternal"
    }
}
