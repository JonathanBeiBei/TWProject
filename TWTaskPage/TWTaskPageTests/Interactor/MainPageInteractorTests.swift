//
//  MainPageInteractorTests.swift
//  TWTaskPageTests
//
//  Created by Beibei Zhu on 2021/9/24.
//

import XCTest
@testable import TWTaskPage

class MainPageInteractorTests: XCTestCase {

    var testModelArray: [DataModel]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFilter() {
        testModelArray = [
            DataModel(id: "1", authorId: "11", tab: "ask", content: "askContentOne", title: "askTitleOne", lastReplyAt: "2021-09-22T09:30:30", good: true, top: true, replyCount: 150, visitCount: 120, createTime: "2021-09-22T09:30:30", author: Author(loginname: "autorNameOne", avatarUrl: "http://asdf")),
            DataModel(id: "2", authorId: "22", tab: "ask", content: "askContentTwo", title: "askTitleTwo", lastReplyAt: "2021-09-22T09:30:30", good: true, top: true, replyCount: 250, visitCount: 220, createTime: "2021-09-22T09:30:30", author: Author(loginname: "autorNameTwo", avatarUrl: "http://asdf")),
            DataModel(id: "3", authorId: "33", tab: "ask", content: "askContentThree", title: "askTitleThree", lastReplyAt: "2021-09-22T09:30:30", good: true, top: true, replyCount: 350, visitCount: 320, createTime: "2021-09-22T09:30:30", author: Author(loginname: "autorNameThree", avatarUrl: "http://asdf")),
            DataModel(id: "4", authorId: "44", tab: "ask", content: "askContentFour", title: "askTitleFour", lastReplyAt: "2021-09-22T09:30:30", good: true, top: true, replyCount: 450, visitCount: 420, createTime: "2021-09-22T09:30:30", author: Author(loginname: "autorNameFour", avatarUrl: "http://asdf")),
            DataModel(id: "5", authorId: "55", tab: "ask", content: "askContentFive", title: "askTitleFive", lastReplyAt: "2021-09-22T09:30:30", good: true, top: true, replyCount: 550, visitCount: 520, createTime: "2021-09-22T09:30:30", author: Author(loginname: "autorNameFive", avatarUrl: "http://asdf"))
        ]
        
        let interactor = MainPageInteractor()
        let models = interactor.filterViaText("ONE", originalData: testModelArray)
        XCTAssertEqual(models?.count, 1)
        
        let emptyModels = interactor.filterViaText("asdfasdf", originalData: testModelArray)
        XCTAssertEqual(emptyModels?.count, 0)
        
        let allModels = interactor.filterViaText("ASK", originalData: testModelArray)
        XCTAssertEqual(allModels?.count, 5)
        
    }

}
