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
    func getSuccessfulSelectedOneData(_ model: ResultData) {
        viewController?.displaySuccessfulSelectedOneData(model)
    }
    
    func getFailureSelectedOneData() {
        viewController?.displayFailureSelectedOneData()
    }
}
