//
//  BuySellCategotylist.swift
//  SocietyMangement
//
//  Created by MacMini on 18/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - BuySellCategoryList
struct BuySellCategoryList: Codable {
    let data: [BuySellCategoryData]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct BuySellCategoryData: Codable {
    let id: Int?
    let name: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id = "ProductCategoryID"
        case name = "Name"
        case icon = "Icon"
    }
}

/*

// MARK: - BuySellCategoryList
struct BuySellCategoryList: Codable {
    let data: [BuySellCategoryData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct BuySellCategoryData: Codable {
    let id: Int?
    let name, icon: String?
}

*/
