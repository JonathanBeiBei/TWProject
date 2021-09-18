//
//  HomePagePresenter.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

class HomePagePresenter: NSObject {
    weak var viewController: HomePageViewControllerInterface?
}

extension HomePagePresenter: HomePagePresenterInterface {
    func getSuccessfulTabAskData(_ model: ResultData) {
        viewController?.displaySuccessfulTabAskData(model)
    }
    
    func getFailureTabAskData() {
        viewController?.displayFailureTabAskData()
    }
    
    func getSuccessfulTabShareData(_ model: ResultData) {
        viewController?.displaySuccessfulTabShareData(model)
    }
    func getFailureTabShareData() {
        viewController?.displayFailureTabShareData()
    }
    
    func searchResult(_ result: [DataModel]?) {
        viewController?.displaySearchResult(result)
    }
}
