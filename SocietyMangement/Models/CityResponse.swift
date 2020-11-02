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
    let CityID: Int?
    let Name: String?

    
    enum CodingKeys: String, CodingKey {
        case CityID
        case Name = "Name"
        
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


/*
 
 // 19/10/20.

 {
     "data": [
         {
             "CityID": 1,
             "Name": "Ahmedabad"
         },
         {
             "CityID": 2,
             "Name": "Bangalore"
         },
         {
             "CityID": 3,
             "Name": "Chennai"
         },
         {
             "CityID": 4,
             "Name": "Delhi"
         },
         {
             "CityID": 5,
             "Name": "Hyderabad"
         },
         {
             "CityID": 6,
             "Name": "Jaipur"
         },
         {
             "CityID": 7,
             "Name": "Kolkata"
         },
         {
             "CityID": 8,
             "Name": "Mumbai"
         },
         {
             "CityID": 9,
             "Name": "Pune"
         },
         {
             "CityID": 10,
             "Name": "Surat"
         }
     ],
     "status": 1,
     "message": "Get cities done"
 }
 
 */
