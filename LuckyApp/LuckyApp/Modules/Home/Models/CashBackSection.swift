//
//  CashBackSection.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import UIKit

struct CashBackSection: Codable {
    var title: String?
    var items: [CashBackItem]

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case items = "items"
    }
}
