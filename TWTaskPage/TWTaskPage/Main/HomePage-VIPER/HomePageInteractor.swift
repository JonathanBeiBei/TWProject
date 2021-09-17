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
            guard let tabKey = requestParameters?[RequestKey.Tab.rawValue] as? String else{
                return
            }
            switch tabKey {
            case TableType.AskType.rawValue:
                if let model = responseModel {
                    self.presenter?.getSuccessfulTabAskData(model)
                } else {
                    self.presenter?.getFailureTabAskData()
                }
            case TableType.ShareType.rawValue:
                if let model = responseModel {
                    self.presenter?.getSuccessfulTabShareData(model)
                } else {
                    self.presenter?.getFailureTabShareData()
                }
            default:
                break
            }
        })
    }
}
