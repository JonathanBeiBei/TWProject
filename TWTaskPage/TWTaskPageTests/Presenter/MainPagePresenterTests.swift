//
//  MainPagePresenterTests.swift
//  TWTaskPageTests
//
//  Created by Beibei Zhu on 2021/9/24.
//

import XCTest
import RxSwift
@testable import TWTaskPage

class MainPagePresenterTests: XCTestCase {
    
    private let askDisposeBag = DisposeBag()
    private let shareDisposeBag = DisposeBag()
    private let filterDisposeBag = DisposeBag()
    
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
    
    func testPublishAskResult() {
        let interactor = MainPageInteractorMock()
        let presenter = MainPagePresenter(interactor: interactor)
        presenter.loadDisplayContents([RequestKey.Tab.rawValue: TableType.AskType.rawValue])
        presenter.askContentObservable?.subscribe(
            onNext: { model in
                let totalData = model?.data
                guard let modelArray = totalData else {
                    return
                }
                XCTAssertEqual(TableType.AskType.rawValue, modelArray[0].tab)
                XCTAssertEqual(TableType.AskType.rawValue, modelArray[1].tab)
                XCTAssertEqual("askContentOne", modelArray[0].content)
            }).disposed(by: askDisposeBag)
    }
    
    
    func testPublishShareResult() {
        let interactor = MainPageInteractorMock()
        let presenter = MainPagePresenter(interactor: interactor)
        presenter.loadDisplayContents([RequestKey.Tab.rawValue: TableType.ShareType.rawValue])
        presenter.shareContentObservable?.subscribe(
            onNext: { model in
                let totalData = model?.data
                guard let modelArray = totalData else {
                    return
                }
                XCTAssertEqual(TableType.ShareType.rawValue, modelArray[0].tab)
                XCTAssertEqual(TableType.ShareType.rawValue, modelArray[1].tab)
                XCTAssertEqual("shareContentOne", modelArray[0].content)
            }).disposed(by: shareDisposeBag)
    }
    
    func testPublishFilterResult() {
        let interactor = MainPageInteractorMock()
        let presenter = MainPagePresenter(interactor: interactor)
        presenter.filterContentUpdated.subscribe(
            onNext: { models in
                guard let modelArray = models else {
                    return
                }
                XCTAssertEqual("askContentOne", modelArray[0].content)
                XCTAssertEqual("1", modelArray[0].id)
                XCTAssertEqual("askTitleOne", modelArray[0].title)
            }).disposed(by: shareDisposeBag)
        presenter.searchActions("", originalData: nil)
    }
    
    
}
