//
//  FlatResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation


//// MARK: - City
//struct FlatResponse: Codable {
//    let data: [Flat]
//    let status: Int
//    let message: String
//}
//
//// MARK: - Datum
//struct Flat: Codable {
//    let id, buildingID: Int
//    let name: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case buildingID = "building_id"
//        case name
//    }
//}




// MARK: - FlatResponse
struct FlatResponse: Codable {
    let data: [Flat]?
    let status: Int
    let message: String
}

// MARK: - Flat
struct Flat: Codable {
    let PropertyID: Int?
    let propertyFullName, PropertyName: String?
    let societyID, parentPropertyID, isCommercial, isActiveOwner: Int?
    let isActiveTenant: Int?
    let type: TypeProperty?

    enum CodingKeys: String, CodingKey {
        case PropertyID = "PropertyID"
        case propertyFullName = "PropertyFullName"
        case PropertyName = "PropertyName"
        case societyID = "SocietyID"
        case parentPropertyID = "ParentPropertyID"
        case isCommercial = "IsCommercial"
        case isActiveOwner = "IsActiveOwner"
        case isActiveTenant = "IsActiveTenant"
        case type = "Type"
    }
}

// MARK: - TypeClass
struct TypeProperty: Codable {
    let propertyTypeID: Int?
    let propertyTypeName: String? //PropertyTypeName
    let logo: String?

    enum CodingKeys: String, CodingKey {
        case propertyTypeID = "PropertyTypeID"
        case propertyTypeName = "PropertyTypeName"
        case logo
    }
}



// 2/11/20.

/*

// MARK: - AddRatingReviewResponse
struct FlatResponse: Codable {
    let data: [Flat]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct Flat: Codable {
    let PropertyID: Int?
    let PropertyName: String?
    let SocietyID: Int?
    let ParentPropertyID: Int?
    let PropertyTypeID: Int?
    let PropertyTypeName: String?
    let isCommercial: Int?
    let isActiveOwner, isActiveTenant: Int?
    //, isActive: Int


    enum CodingKeys: String, CodingKey {
        case PropertyID, SocietyID, ParentPropertyID
        case PropertyName = "PropertyName"
        case PropertyTypeID
        case PropertyTypeName = "PropertyTypeName"
        case isCommercial = "IsCommercial"
        case isActiveOwner = "IsActiveOwner"
        case isActiveTenant = "IsActiveTenant"
       // case isActive = "IsActive"
    }
}

*/


/*
 
// MARK: - Datum
struct Flat: Codable {
    let id: Int?
    let name: String?
    let buildingID: Int?
    let booked, bookType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case buildingID = "building_id"
        case booked
        case bookType = "book_type"
    }
}

*/


