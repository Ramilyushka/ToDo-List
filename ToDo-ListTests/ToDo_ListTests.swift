//
//  ToDo_ListTests.swift
//  ToDo-ListTests
//
//  Created by Наиль on 08/11/25.
//

import Testing

struct ToDo_ListTests {

    var sut: TodosInteractorProtocol!
    var network: MockNetwork!
    var coreData: MockCoreData!
    var output: MockOutput!

    func setUp() {
        super.setUp()
        network = MockNetwork()
        coreData = MockCoreData()
        output = MockOutput()
        sut = TodosInteractor(network: network, coreData: coreData)
        sut.output = output
    }

    override func tearDown() {
        sut = nil
        network = nil
        coreData = nil
        output = nil
        super.tearDown()
    }

    // MARK: - Tests
    func test_fetch_shouldLoadFromAPI_whenFirstLaunch() {
        sut.fetch()
        XCTAssertTrue(network.getTodosCalled)
    }
}
