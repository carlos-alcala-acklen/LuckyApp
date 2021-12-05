//
//  CashBackSection.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import UIKit

struct CashBackData: Codable {
    var title: String?
    var sections: [CashBackSection]

    enum CodingKeys: String, CodingKey {
        case title
        case sections
    }
}
