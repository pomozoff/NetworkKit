import XCTest
@testable import NetworkKit

final class NetworkKitTests: XCTestCase {
    func testTargetFetching() {
        let featureList = TestAPI.featureList
        let expectation = XCTestExpectation(description: "Fetch feature list")

        let session = URLSessionMock()
        session.data = Bundle.module.readData(from: "featuresList1.json")
        session.response = HTTPURLResponse(url: featureList.url!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let provider = NetworkKit.Provider<TestAPI>(urlSession: session)
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

        wait(for: [expectation], timeout: 1.0)
    }

    private let parser = Parser()
}
