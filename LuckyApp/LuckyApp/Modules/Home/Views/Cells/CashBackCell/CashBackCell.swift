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
            print("brand.font \(brand.font.fontName)")
            print("brand.font \(brand.font.fontDescriptor)")
        }
    }
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.font = UIFont(name: "SFProText-Bold", size: 16)
            print("title.font \(title.font.fontName)")
            print("title.font \(title.font.fontDescriptor)")
        }
    }
    @IBOutlet weak var tags: UILabel! {
        didSet {
            tags.font = UIFont(name: "SFProText-Regular", size: 10)
            print("tags.font \(tags.font.fontName)")
            print("tags.font \(tags.font.fontDescriptor)")
        }
    }
    @IBOutlet weak var likes: UILabel! {
        didSet {
            likes.font = UIFont(name: "SFProText-Regular", size: 10)
            print("likes.font \(likes.font.fontName)")
            print("likes.font \(likes.font.fontDescriptor)")
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
