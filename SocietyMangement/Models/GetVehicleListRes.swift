//
//  GetVehicleListRes.swift
//  SocietyMangement
//
//  Created by Innovius on 18/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - GetVehicleList
struct GetVehicleList: Codable {
    let data: [VehicleData]
    let status: Int
    let message: String
}

// MARK: - Datum
struct VehicleData: Codable {
    let id: Int?
    let number, type: String?
}
