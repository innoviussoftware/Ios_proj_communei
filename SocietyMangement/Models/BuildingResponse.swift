//
//  BuildingResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation


// MARK: - City
struct BuildingResponse: Codable {
    let data: [Building]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Building: Codable {
    let PropertyID, SocietyID: Int
    let PropertyName: String
    
    enum CodingKeys: String, CodingKey {
        case PropertyID
        case SocietyID
        case PropertyName = "PropertyName"
    }
}


/*
 
 
 // MARK: - City
 struct BuildingResponse: Codable {
     let data: [Building]
     let status: Int
     let message: String
 }

 // MARK: - Datum
 struct Building: Codable {
     let id, societyID: Int
     let name: String
     
     enum CodingKeys: String, CodingKey {
         case id
         case societyID = "society_id"
         case name
     }
 }
 
 */

/*
 
 {
     "data": [
         {
             "PropertyID": 10,
             "SocietyID": 5,
             "PropertyName": "Common Area 1",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 1,
             "Type": {
                 "PropertyTypeID": 6,
                 "PropertyTypeName": "Stall Complex",
                 "Logo": null
             }
         },
         {
             "PropertyID": 11,
             "SocietyID": 5,
             "PropertyName": "Common Area 2",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 1,
             "Type": {
                 "PropertyTypeID": 6,
                 "PropertyTypeName": "Stall Complex",
                 "Logo": null
             }
         },
         {
             "PropertyID": 1,
             "SocietyID": 5,
             "PropertyName": "Green Leaves",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 1,
                 "PropertyTypeName": "Apartment",
                 "Logo": null
             }
         },
         {
             "PropertyID": 2,
             "SocietyID": 5,
             "PropertyName": "Lotus",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 1,
                 "PropertyTypeName": "Apartment",
                 "Logo": null
             }
         },
         {
             "PropertyID": 3,
             "SocietyID": 5,
             "PropertyName": "Orchid Block A",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 1,
                 "PropertyTypeName": "Apartment",
                 "Logo": null
             }
         },
         {
             "PropertyID": 4,
             "SocietyID": 5,
             "PropertyName": "Orchid Block B",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 1,
                 "PropertyTypeName": "Apartment",
                 "Logo": null
             }
         },
         {
             "PropertyID": 5,
             "SocietyID": 5,
             "PropertyName": "Phase 2 Villa",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 4,
                 "PropertyTypeName": "Villas Group",
                 "Logo": null
             }
         },
         {
             "PropertyID": 6,
             "SocietyID": 5,
             "PropertyName": "Sahitya",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 1,
                 "PropertyTypeName": "Apartment",
                 "Logo": null
             }
         },
         {
             "PropertyID": 7,
             "SocietyID": 5,
             "PropertyName": "Space One",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 1,
                 "PropertyTypeName": "Apartment",
                 "Logo": null
             }
         },
         {
             "PropertyID": 8,
             "SocietyID": 5,
             "PropertyName": "Tulip",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 1,
                 "PropertyTypeName": "Apartment",
                 "Logo": null
             }
         },
         {
             "PropertyID": 9,
             "SocietyID": 5,
             "PropertyName": "Villa",
             "PropertyFullName": null,
             "ParentPropertyID": 0,
             "IsCommercial": 0,
             "Type": {
                 "PropertyTypeID": 4,
                 "PropertyTypeName": "Villas Group",
                 "Logo": null
             }
         }
     ],
     "status": 1,
     "message": "Get buildings done"
 }
 
 */

