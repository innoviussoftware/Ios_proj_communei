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
    let isExist, role: String?
    let otp: Int?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case isExist = "is_exist"
        case role, otp, token
    }
}

