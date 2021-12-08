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
    @IBOutlet weak var brand: UILabel! {
        didSet {
            brand.font = UIFont(name: "SFProText-Regular", size: 10)
        }
    }
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.font = UIFont(name: "SFProText-Bold", size: 16)
        }
    }
    @IBOutlet weak var tags: UILabel! {
        didSet {
            tags.font = UIFont(name: "SFProText-Regular", size: 10)
        }
    }
    @IBOutlet weak var likes: UILabel! {
        didSet {
            likes.font = UIFont(name: "SFProText-Regular", size: 10)
        }
    }

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
        brand.text = (cashback.brand ?? "").uppercased()
        tags.text = cashback.tags ?? ""
        likes.text = cashback.likes
    }

    override func prepareForReuse() {
        image.image = nil
    }
}
