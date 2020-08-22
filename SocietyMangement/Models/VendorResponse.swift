//
//  VendorResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 05/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - VendorsResponse
struct VendorsResponse: Codable {
    let data: [Vendor]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

// MARK: - Datum
struct Vendor: Codable {
    let id, societyID, memberID, vendorName: String
    let vendorProfession, vendorEmail, vendorPhone, vendorProfile: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case memberID = "member_id"
        case vendorName = "vendor_name"
        case vendorProfession = "vendor_profession"
        case vendorEmail = "vendor_email"
        case vendorPhone = "vendor_phone"
        case vendorProfile = "vendor_profile"
    }
}
