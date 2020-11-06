//
//  AddEventTypeResponse.swift
//  SocietyMangement
//
//  Created by prakash soni on 28/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - AddEventTypeResponse
struct AddEventTypeResponse: Codable {
    let data: [AddEventType]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct AddEventType: Codable {
    let eventTypeID, societyID: Int
    let name: String
    let datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case eventTypeID = "EventTypeID"
        case societyID = "SocietyID"
        case name = "Name"
        case datumDescription = "Description"
    }
}

