//
//  CashBackCell.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 6/13/21.
//

import UIKit
import SDWebImage

class CashBackCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tags: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        image.setupRoundedCorners(radius: 2)
        image.setupBorder(color: .lightGray)
    }

    public func configure(with cashback: CashBackItem) {
        image.sd_imageIndicator = SDWebImageActivityIndicator.white
        image.sd_setImage(with: URL(string: cashback.imageUrl ?? ""), placeholderImage: UIImage())
        title.text = cashback.title ?? ""
        brand.text = cashback.brand ?? ""
        tags.text = cashback.tags ?? ""
    }

    override func prepareForReuse() {
        image.image = nil
    }
}
