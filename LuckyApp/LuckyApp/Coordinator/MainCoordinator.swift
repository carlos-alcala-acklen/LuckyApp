//
//  MainCoordinator.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController.instantiate(withStoryboard: "Home")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func showCashBackDetail(cashback: CashBackItem) {
        let vc = DetailsViewController.instantiate(withStoryboard: "Details")
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        vc.viewModel.cashback = cashback
        navigationController.pushViewController(vc, animated: true)
    }
}
