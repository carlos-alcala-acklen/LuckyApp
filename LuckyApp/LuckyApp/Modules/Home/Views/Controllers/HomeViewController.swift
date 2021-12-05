//
//  HomeViewController.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Variables
    weak var coordinator: MainCoordinator?

    let viewModel = HomeViewModel()

    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }

    // MARK: - Functions
    func setupUI() {
        view.backgroundColor = .white

        collectionView.registerCell(CashBackCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10

        let columns: CGFloat = 3
        let offset: CGFloat = 32 + 30
        let height: CGFloat = 220
        let width: CGFloat = (self.view.frame.width - offset) / columns

        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 20, right: 16)
        collectionView.collectionViewLayout = layout
    }

    func refreshUI() {
        self.collectionView.reloadData()
    }

    func loadData() {
        viewModel.fetchData(handler: { result in
            switch result {
            case .success:
//                self.refreshUI()
                print("success")
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        })
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cashback = viewModel.items[indexPath.row]
        coordinator?.showCashBackDetail(cashback: cashback)
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashBackCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let cashback = viewModel.items[indexPath.row]
        cell.configure(with: cashback)
        return cell
    }
}

//MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 10.0 {
            loadData()
        }
    }
}
