//
//  HomeViewModelTests.swift
//  LuckyAppTests
//
//  Created by Carlos Alcala on 4/12/2021.
//

import XCTest
import LuckyApp

class HomeViewModelTests: XCTestCase {

    var viewModel : HomeViewModel?
    private var service : MockService?

    override func setUp() {
        super.setUp()
        self.service = MockService()
        self.viewModel = HomeViewModel(service: service)
    }

    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }

    func testloadNextPageWithNoService() {

        // giving no service to a view model
        viewModel?.service = nil

        viewModel?.fetchData(handler: { result in
            switch result {
            case .success:
                XCTAssert(false, "ViewModel should not be able to load without service")
            case .failure:
                XCTAssert(false, "ViewModel should not be able to load without service")
            }
        })
    }

    func testloadDataWithCashBackService() {

        // setting up expectation
        let dataExpectation = expectation(description: "fetchData expectation")

        // inject CashBackService service to test view model real callback
        self.viewModel = HomeViewModel(service: CashBackService())

        self.viewModel?.fetchData(handler: { result in
            switch result {
            case .success:
                XCTAssertNotNil(self.viewModel?.data, "ViewModel data should be valid")
                let title = self.viewModel?.data?.title ?? ""
                XCTAssertEqual(title, "Offers", "ViewModel pages should count 500")
                XCTAssertTrue(self.viewModel?.data?.sections.count == 2, "ViewModel sections should count 2")
                XCTAssertTrue(self.viewModel?.items.count == 8, "ViewModel total items should count 8")
                dataExpectation.fulfill()
            case .failure:
                XCTAssert(false, "ViewModel should not fail on this service")
                dataExpectation.fulfill()
            }
        })

        // check for expectation
        wait(for: [dataExpectation], timeout: 60)
    }
}

private class MockService : ServiceProtocol {
    var requestCalled: Bool = false
    func GETRequest<T: Codable>(_ parameters: [String: String], completionBlock: @escaping (Response<T>) -> Void) {
        requestCalled = true
    }
}
