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
        collectionView.registerHeaderCell(CashBackHeaderCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 24

        let height: CGFloat = 80
        let headerHeight: CGFloat = 60
        let width: CGFloat = self.collectionView.frame.width - 48

        print("width \(width)")

        layout.itemSize = CGSize(width: width, height: height)
        layout.headerReferenceSize = CGSize(width: width, height: headerHeight)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
        collectionView.collectionViewLayout = layout
    }

    func refreshUI() {
        self.collectionView.reloadData()
    }

    func loadData() {
        viewModel.fetchData(handler: { result in
            switch result {
            case .success:
                self.refreshUI()
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
        let section = viewModel.data?.sections[indexPath.section]
        guard let cashback = section?.items[indexPath.row] else {
            return
        }
        coordinator?.showCashBackDetail(cashback: cashback)
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.data?.sections.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.data?.sections[section]
        return section?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let cell: CashBackHeaderCell = collectionView.dequeueReusableHeaderCell(forIndexPath: indexPath)
            let title = viewModel.data?.sections[indexPath.section].title ?? ""
            cell.backgroundColor = .blue
            cell.configure(with: title)

            return cell

//        let searchTerm = searches[indexPath.section].searchTerm
//        typedHeaderView.titleLabel.text = searchTerm
//        return typedHeaderView
        default:
            assert(false, "Invalid element type")
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashBackCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let section = viewModel.data?.sections[indexPath.section]
        guard let cashback = section?.items[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(with: cashback)
        cell.backgroundColor = .yellow
        return cell
    }
}
