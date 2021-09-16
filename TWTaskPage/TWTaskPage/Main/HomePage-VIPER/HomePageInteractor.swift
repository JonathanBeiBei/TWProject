//
//  HomePageInteractor.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

class HomePageInteractor: NSObject {
    var presenter: HomePagePresenterInterface?
    var worker: HomePageWorkerProtocol?
}

extension HomePageInteractor: HomePageInteractorInterface {
    func obtainSelectedOneData(requestParameters: [String: Any]?) {
        self.worker?.obtainSelectedOneData(requestParameters: requestParameters, responseCompletion: { responseModel in
            if let model = responseModel {
                self.presenter?.getSuccessfulSelectedOneData(model)
            } else {
                self.presenter?.getFailureSelectedOneData()
            }
        })
    }
}
