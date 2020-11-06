//
//  GetVehicleUserList.swift
//  SocietyMangement
//
//  Created by prakash soni on 26/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation



// MARK: - GetVehicleUserList
struct GetVehicleUserList: Codable {
    let data: [VehicleDataUser]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct VehicleDataUser: Codable {
    let id: Int
    let number: String
    let numberDigits, vehicleTypeID: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id = "VehicleID"
        case number = "Number"
        case numberDigits = "NumberDigits"
        case vehicleTypeID = "VehicleTypeID"
        case type = "Type"
    }
}
