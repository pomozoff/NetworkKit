import XCTest
@testable import NetworkKit

final class NetworkKitTests: XCTestCase {
    func testTargetFetching() {
        let featureList = TestAPI.featureList
        let expectation = XCTestExpectation(description: "Fetch feature list")

        let url = featureList.url!
        let data = Bundle.module.readData(from: "featuresList1.json")
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        URLProtocolMock.mockURLs = [url: (nil, data, response)]

        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: sessionConfiguration)

        let provider = NetworkKit.Provider<TestAPI>(urlSession: mockSession)
        provider.request(featureList) { [unowned self] result in
            switch result {
            case let .success(response):
                do {
                    let features: [Feature] = try parser.parse(response)
                    XCTAssert(features.count == 2, "Invalid features count")
                } catch {
                    XCTFail("Error: \(error)")
                }
            case let .failure(error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.defaultTimeout)
    }

    private let parser = Parser()
}

private enum Constants {
    static let defaultTimeout = 1.0
}
