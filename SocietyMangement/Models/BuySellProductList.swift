//
//  BuySellProductList.swift
//  SocietyMangement
//
//  Created by MacMini on 18/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - BuySellProductList
struct BuySellProductList: Codable {
    let data: [BuySellProductListData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct BuySellProductListData: Codable {
    let id, userID, categoryID: Int?
    let title, price, quality, datumDescription: String?
    let flag: Int?
    let username, buildingname, phone, image: String?
    let categoryname: String?
    let productsimages: [Productsimage]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case title, price, quality
        case datumDescription = "description"
        case flag, username, buildingname, phone, image, categoryname, productsimages
    }
}

// MARK: - Productsimage
struct Productsimage: Codable {
    let id, productID: Int?
    let image, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
