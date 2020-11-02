//
//  BuildingAddResponse.swift
//  SocietyMangement
//
//  Created by prakash soni on 27/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - BuildingAddResponse
struct BuildingAddResponse: Codable {
    let data: [BuildingAdd]
    let status: Int
    let message: String
}

// MARK: - Datum
struct BuildingAdd: Codable {
    let propertyID: Int
    let propertyFullName, propertyName: String
    let societyID, parentPropertyID, isCommercial: Int
    //let isActiveOwner: Int  //isActive: Int
  //  let isActiveTenant: Int
    let type: BuildingNew?

    enum CodingKeys: String, CodingKey {
        case propertyID = "PropertyID"
        case propertyFullName = "PropertyFullName"
        case propertyName = "PropertyName"
        case societyID = "SocietyID"
        case parentPropertyID = "ParentPropertyID"
        case isCommercial = "IsCommercial"
      //  case isActive = "IsActive"
       // case isActiveOwner = "IsActiveOwner"
      //  case isActiveTenant = "IsActiveTenant"
        case type = "Type"
    }
}

// MARK: - TypeClass
struct BuildingNew: Codable {
    let propertyTypeID: Int
    let propertyTypeName: String // PropertyTypeName?
    let logo: String?

    enum CodingKeys: String, CodingKey {
        case propertyTypeID = "PropertyTypeID"
        case propertyTypeName = "PropertyTypeName"
        case logo
    }
}

