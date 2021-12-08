//
//  HomeViewModel.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import Foundation

enum CashBackError: Error {
    case dataFailure
    case noMorePages
    case unexpected(code: Int)
}

class HomeViewModel: NSObject {
    var data: CashBackData?
    var items: [CashBackItem] = []
    var searchResults: [CashBackItem] = []
    var service: ServiceProtocol?

    init(service: ServiceProtocol? = CashBackService()) {
        self.service = service
    }
}

extension HomeViewModel {
    func fetchData(handler: @escaping (Result<Void, CashBackError>) -> Void) {

        let params: [String : String] = [:]

        service?.GETRequest(params) { (response: Response<CashBackData>) in
            switch response {
            case .success(let data):

                self.data = data

                for section in data.sections {
                    for item in section.items {
                        self.items.append(item)
                    }
                }

                handler(.success(()))

            case .failure(let error):
                print("error.code \(String(describing: error.code))")
                print("error.message \(String(describing: error.message))")
                handler(.failure(.dataFailure))
            default:
                break
            }
        }
    }

    func search(for searchText: String) {
        self.searchResults = items.filter({ item -> Bool in
            guard let title = item.title else { return false }
            let match = title.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
}
