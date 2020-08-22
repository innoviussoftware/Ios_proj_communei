//   let cityResponse = try? newJSONDecoder().decode(CityResponse.self, from: jsonData)

import Foundation



// MARK: - City
struct CityResponse: Codable {
    let data: [City]
    let status: Int
    let message: String
}

// MARK: - Datum
struct City: Codable {
    let id: Int
    let name: String
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}





//
//// MARK: - CityResponse
//struct CityResponse: Codable {
//    let data: [City]
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
//struct City: Codable {
//    let id, name, status: String
//    let createdAt, updatedAt: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
