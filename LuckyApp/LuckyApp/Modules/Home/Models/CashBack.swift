//
//  CashBackItem.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import Foundation

struct CashBackItem: Codable {
    var title: String?
    var brand: String?
    var tags: String?
    var favoriteCount: Int?
    var detailUrl: String?
    var imageUrl: String?
    var overview: String? {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pretium aenean pharetra magna ac placerat vestibulum lectus. Dictumst quisque sagittis purus sit amet volutpat consequat mauris. Vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare. Viverra aliquet eget sit amet tellus. Sit amet justo donec enim diam vulputate ut. Vel facilisis volutpat est velit egestas dui id. A scelerisque purus semper eget. Volutpat commodo sed egestas egestas fringilla phasellus. Urna molestie at elementum eu facilisis sed. Velit ut tortor pretium viverra. Sit amet volutpat consequat mauris nunc congue. Accumsan in nisl nisi scelerisque eu. Duis at consectetur lorem donec massa sapien faucibus et. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pretium aenean pharetra magna ac placerat vestibulum lectus. Dictumst quisque sagittis purus sit amet volutpat consequat mauris. Vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare. Viverra aliquet eget sit amet tellus. Sit amet justo donec enim diam vulputate ut. Vel facilisis volutpat est velit egestas dui id. A scelerisque purus semper eget. Volutpat commodo sed egestas egestas fringilla phasellus. Urna molestie at elementum eu facilisis sed. Velit ut tortor pretium viverra. Sit amet volutpat consequat mauris nunc congue. Accumsan in nisl nisi scelerisque eu. Duis at consectetur lorem donec massa sapien faucibus et. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pretium aenean pharetra magna ac placerat vestibulum lectus. Dictumst quisque sagittis purus sit amet volutpat consequat mauris. Vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare. Viverra aliquet eget sit amet tellus. Sit amet justo donec enim diam vulputate ut. Vel facilisis volutpat est velit egestas dui id. A scelerisque purus semper eget. Volutpat commodo sed egestas egestas fringilla phasellus. Urna molestie at elementum eu facilisis sed. Velit ut tortor pretium viverra. Sit amet volutpat consequat mauris nunc congue. Accumsan in nisl nisi scelerisque eu. Duis at consectetur lorem donec massa sapien faucibus et."
    }

    var price: Float? {
        return 500.0
    }

    var priceString: String? {
        return "EGP\(price ?? 0)"
    }

    var expirationDate: String? {
        return "Exp.28 April 2020"
    }

    var redemptions: Int? {
        return 4
    }

    var redemptionsString: String {
        return "REDEMPTIONS CAP: \(redemptions ?? 0) TIMES"
    }

    var likes: String {
        let count: Double = Double(favoriteCount ?? 0)
        guard count > 1000 else {
            let likes: Double = count
            return likes.stringWithoutZeroFraction
        }
        let likes: Double = (count / 1000)
        let format = "%.1fK"
        return String(format: format, likes)
    }

    enum CodingKeys: String, CodingKey {
        case title
        case brand
        case tags
        case favoriteCount
        case detailUrl
        case imageUrl
    }
}

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
