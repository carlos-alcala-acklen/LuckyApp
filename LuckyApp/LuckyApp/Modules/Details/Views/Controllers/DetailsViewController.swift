//
//  DetailsViewController.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import UIKit
import SDWebImage
import UIColor_Hex_Swift

class DetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var likeImage: UIImageView! {
        didSet {
            likeImage.isHidden = true
            likeImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            likeImage.alpha = 0.0
        }
    }

    @IBOutlet weak var likesLabel: UILabel! {
        didSet {
            likesLabel.font = UIFont(name: "SFProText-Regular", size: 12)
        }
    }
    @IBOutlet weak var brandLabel: UILabel! {
        didSet {
            brandLabel.font = UIFont(name: "SFProText-Regular", size: 12)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "SFProText-Semibold", size: 32)
        }
    }
    @IBOutlet weak var overviewLabel: UILabel! {
        didSet {
            overviewLabel.font = UIFont(name: "SFProText-Regular", size: 16)
        }
    }
    @IBOutlet weak var priceHintLabel: UILabel! {
        didSet {
            priceHintLabel.font = UIFont(name: "SFProText-Regular", size: 10)
        }
    }
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.font = UIFont(name: "SFProText-Regular", size: 14)
        }
    }
    @IBOutlet weak var realPriceLabel: UILabel! {
        didSet {
            realPriceLabel.font = UIFont(name: "SFProText-Semibold", size: 18)
        }
    }
    @IBOutlet weak var expiredLabel: UILabel! {
        didSet {
            expiredLabel.font = UIFont(name: "SFProText-Regular", size: 10)
        }
    }
    @IBOutlet weak var redemptionsLabel: UILabel! {
        didSet {
            redemptionsLabel.font = UIFont(name: "SFProText-Semibold", size: 12)
        }
    }

    // MARK: - Actions
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func like() {
        animateLike()
    }

    @objc func animateLike() {
        self.likeImage.isHidden = false

        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                            self.likeImage.alpha = 1.0
                       },
                       completion: { finish in

                        UIView.animate(withDuration: 0.8,
                                       delay: 0.1,
                                       options: UIView.AnimationOptions.curveEaseInOut,
                                       animations: {
                                            self.likeImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                                       }, completion: { finish in

                                        UIView.animate(withDuration: 0.5,
                                                      delay: 0.200,
                                                      options: UIView.AnimationOptions.curveEaseOut,
                                                      animations: {
                                                        self.likeImage.alpha = 0.0
                                                        self.likeImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                                                      }, completion: { finish in
                                                        self.likeImage.isHidden = true
                                                        self.isFavorite.toggle()
                                                      })
                                       })
                       })
    }

    // MARK: - Variables

    let viewModel = DetailsViewModel()

    weak var coordinator: MainCoordinator?

    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                navigationItem.rightBarButtonItem = likeButton
            } else {
                navigationItem.rightBarButtonItem = unlikeButton
            }
        }
    }
    var likeButton: UIBarButtonItem?
    var unlikeButton: UIBarButtonItem?

    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }

    // MARK: - Functions
    func setupUI() {
        view.backgroundColor = .white

        image.setupBorder(color: .lightGray)
        title = "CashBack Details"

        self.likeButton = UIBarButtonItem(image: UIImage(named: "likeFilled"), style: .plain, target: self, action: #selector(animateLike))
        self.likeButton?.tintColor = UIColor("#222D34")
        self.unlikeButton = UIBarButtonItem(image: UIImage(named: "like"), style: .plain, target: self, action: #selector(animateLike))
        self.unlikeButton?.tintColor = UIColor("#222D34")
    }

    func loadData() {
        guard let cashback = viewModel.cashback else {
            return
        }

        image.sd_imageIndicator = SDWebImageActivityIndicator.white
        image.sd_setImage(with: URL(string: cashback.imageUrl ?? ""), placeholderImage: UIImage())
        titleLabel.text = cashback.title ?? ""
        brandLabel.text = (cashback.brand ?? "").uppercased()
        overviewLabel.text = cashback.overview ?? ""
        likesLabel.text = cashback.likes
        priceLabel.text = cashback.priceString
        realPriceLabel.text = cashback.priceString
        expiredLabel.text = cashback.expirationDate
        redemptionsLabel.text = cashback.redemptionsString
    }
}
