//
//  DetailsViewController.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    // MARK: - Variables
    let viewModel = DetailsViewModel()

    weak var coordinator: MainCoordinator?

    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }

    // MARK: - Functions
    func setupUI() {
        view.backgroundColor = .white

        image.setupRoundedCorners(radius: 12)
        image.setupBorder(color: .lightGray)
        title = "Details"
    }

    func loadData() {
        guard let cashback = viewModel.cashback else {
            return
        }

        image.sd_imageIndicator = SDWebImageActivityIndicator.white
        image.sd_setImage(with: URL(string: cashback.imageUrl ?? ""), placeholderImage: UIImage())
        brandLabel.text = cashback.brand ?? ""
        titleLabel.text = cashback.title ?? ""
        overviewLabel.text = cashback.overview ?? ""
    }
}
