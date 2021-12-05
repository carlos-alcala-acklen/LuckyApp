//
//  CashBackService.swift
//  LuckyApp
//
//  Created by Carlos Alcala on 4/12/2021.
//  Copyright © 2021 LuckyApp. All rights reserved.
//

import Foundation

protocol ServiceProtocol: AnyObject {
    func GETRequest<T: Codable>(_ parameters: [String: String], completionBlock: @escaping(Response<T>)->Void)
}

final class CashBackService {
    private var serviceBase: ServiceBaseProtocol
    private var endPointName = "HomeEndpoint"

    init(serviceBase: ServiceBaseProtocol = ServiceBase.sharedInstance()) {
        self.serviceBase = serviceBase
    }
}

private extension CashBackService {
    func getEndPoint() -> String {
        guard let path = Bundle.main.url(forResource: "EndPoints", withExtension: "plist"),
              let endPoints = NSDictionary(contentsOf: path) else {
            return ""
        }
        return endPoints.value(forKey: endPointName) as? String ?? ""
    }
}

extension CashBackService: ServiceProtocol {
    func GETRequest<T: Codable>(_ parameters: [String: String], completionBlock: @escaping (Response<T>) -> Void) {
        let endPoint = getEndPoint()
        self.serviceBase.GETRequest(endPoint, parameters: parameters, completionBlock: completionBlock)
    }
}
