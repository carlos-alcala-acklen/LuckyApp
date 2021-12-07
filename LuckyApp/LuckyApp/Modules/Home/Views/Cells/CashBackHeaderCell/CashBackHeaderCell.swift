//
//  CashBackHeaderCell.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 6/13/21.
//

import UIKit
import SDWebImage

class CashBackHeaderCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "SFProText-Medium", size: 24)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with title: String) {
        titleLabel.text = title
    }
}
