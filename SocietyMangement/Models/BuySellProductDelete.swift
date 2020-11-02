//
//  BuySellProductDelete.swift
//  SocietyMangement
//
//  Created by MacMini on 18/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - BuySellProductDelete
struct BuySellProductDelete: Codable {
    let data: [BuySellProductData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct BuySellProductData: Codable {
    let title: String?
    let count: Int?
}
