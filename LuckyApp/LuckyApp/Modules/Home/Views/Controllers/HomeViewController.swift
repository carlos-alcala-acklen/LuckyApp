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

    @IBOutlet weak var countLabel: UILabel!

    // MARK: - Variables
    weak var coordinator: MainCoordinator?

    let viewModel = HomeViewModel()

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search"
        sc.searchBar.showsCancelButton = true
        return sc
    }()

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

        layout.itemSize = CGSize(width: width, height: height)
        layout.headerReferenceSize = CGSize(width: width, height: headerHeight)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
        collectionView.collectionViewLayout = layout
    }

    func refreshUI() {
        self.collectionView.reloadData()
        let count = searchController.isActive ? viewModel.searchResults.count : viewModel.items.count
        countLabel.text = "\(count)"
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

    //MARK: - Private Functions
    private func setupSearchBar() {
        navigationItem.searchController = searchController

        //NOTE: there is an issue with searchBar.becomeFirstResponder not executing correctly
        delay(0.05) { self.searchController.searchBar.becomeFirstResponder() }
    }

    func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

    // MARK: - Actions
    @IBAction func search() {
        setupSearchBar()
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.data?.sections[indexPath.section]

        guard let cashback = searchController.isActive ? viewModel.searchResults[indexPath.row] : section?.items[indexPath.row] else {
            return
        }

        coordinator?.showCashBackDetail(cashback: cashback)
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchController.isActive ? 1 : viewModel.data?.sections.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.data?.sections[section]
        return searchController.isActive ? viewModel.searchResults.count : section?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let cell: CashBackHeaderCell = collectionView.dequeueReusableHeaderCell(forIndexPath: indexPath)

            let title = searchController.isActive ? "" : viewModel.data?.sections[indexPath.section].title ?? ""
            cell.configure(with: title)

            return cell
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashBackCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let section = viewModel.data?.sections[indexPath.section]

        guard let cashback = searchController.isActive ? viewModel.searchResults[indexPath.row] : section?.items[indexPath.row] else {
            return UICollectionViewCell()
        }

        cell.configure(with: cashback)
        return cell
    }
}

//MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            navigationItem.searchController = nil
            refreshUI()
        }

        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.search(for: searchText)
            refreshUI()
        }
    }
}

