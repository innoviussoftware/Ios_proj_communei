//
//  SocietyResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let societyResponse = try? newJSONDecoder().decode(SocietyResponse.self, from: jsonData)

import Foundation


// MARK: - City
struct SocietyResponse: Codable {
    let data: [Society]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Society: Codable {
    let SocietyID: Int
   // let AddressID: Int
    let AreaID: Int
    let SocietyName: String
    
//    let Logo: String
//    let Latitude: String
//    let Longitude: String
//    let guid: String
    
    enum CodingKeys: String, CodingKey {
        case SocietyID //, AddressID
        case AreaID
        case SocietyName = "SocietyName"
        
      //  case Logo, Latitude, Longitude, guid
    }
}




//// MARK: - SocietyResponse
//struct SocietyResponse: Codable {
//    let data: [Society]
//    let errorCode: Int
//    let message: String
//
//    enum CodingKeys: String, CodingKey {
//        case data
//        case errorCode = "error_code"
//        case message
//    }
//}
//
//// MARK: - Datum
//struct Society: Codable {
//    let id, clientID, cityID, areaID: String
//    let societyName, societyAddress, societyEmail, societyPhone: String
//    let societyDocument, status, createDate, updateDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case clientID = "client_id"
//        case cityID = "city_id"
//        case areaID = "area_id"
//        case societyName = "society_name"
//        case societyAddress = "society_address"
//        case societyEmail = "society_email"
//        case societyPhone = "society_phone"
//        case societyDocument = "society_document"
//        case status
//        case createDate = "create_date"
//        case updateDate = "update_date"
//    }
//}



/*
 
 // 20/10/20.
 
 {
     "data": [
         {
             "SocietyID": 5,
             "SocietyName": "Vasantha Valley",
             "AreaID": 9,
             "AddressID": null,
             "Logo": null,
             "Latitude": null,
             "Longitude": null,
             "guid": null
         }
     ],
     "status": 1,
     "message": "Get societies done"
 }
 
 */
