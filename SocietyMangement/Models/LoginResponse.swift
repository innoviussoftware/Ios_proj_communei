// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? newJSONDecoder().decode(LoginResponse.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? newJSONDecoder().decode(LoginResponse.self, from: jsonData)

import Foundation


//
//
//// MARK: - City
//struct loginResponse: Codable {
//    let data: dataType
//    let status : Int
//    let message: String
//}
//
//// MARK: - DataClass
//struct dataType: Codable {
//    let isExist, role: String
//    let otp: Int
//    let token: String?
//
//    enum CodingKeys: String, CodingKey {
//        case isExist = "is_exist"
//        case role, otp, token
//    }
//}



// MARK: - Welcome
struct loginResponse: Codable {
    let data: dataType?
    let status: Int
    let message: String
    let isapporve: Int?
}

// MARK: - DataClass
struct dataType: Codable {
    let is_exist: Bool?
    let role: String?
    let token: String?
    let otp: String? //Int?
    let Secret: String?

    enum CodingKeys: String, CodingKey {
        case is_exist
        case role, otp, token,Secret
    }
}


/*
 
 // 19/10/20.
 
 {
     "status": 1,
     "data": {
         "is_exist": false,
         "token": "",
         "otp": "3632",
         "Secret": "eyJpdiI6IkpDMWhBYVB4ZDE2T3FCY25vU1JKblE9PSIsInZhbHVlIjoiTHUyZXlsdG9DbWtRRWNqYmlsYUhGVVdIcVZVSFY4UFB2TEpwMityVEpvOD0iLCJtYWMiOiJmZTdiZWJkMjk0NjBiMjAwYjFkNTgxNDYxNTA2MWE0OGNiMTQ4Y2E3M2FhNjc2Y2M2NDk2MDM3OTE5MGYxYTc3In0="
     },
     "message": "Signup OTP sent successfully",
     "isapporve": 0
 }
 
 */

