//
//  Storyboarded.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
    static func instantiate(withStoryboard storyboardName: String?) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        instantiate(withStoryboard: "Main")
    }

    static func instantiate(withStoryboard storyboardName: String?) -> Self {
        let controllerName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName ?? controllerName, bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: controllerName) as? Self {
            return controller
        } else if let controller = storyboard.instantiateInitialViewController() as? Self {
            return controller
        }
        fatalError("Could not find storyboard with name \(storyboardName ?? controllerName)")
    }
}

extension UIViewController: Storyboarded {}
