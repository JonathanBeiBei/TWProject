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
    
    func searchAction(_ text: String, originalData: [DataModel]?) {
        self.presenter?.searchResult(filterFromText(text, originalData: originalData))
    }
    
    func filterFromText(_ text: String, originalData: [DataModel]?) -> [DataModel]? {
        guard let modelArray = originalData else {
            return nil
        }
        if text.isEmpty  {
            return modelArray
        }
        return modelArray.filter { item in
            var filtered = false
            if let name = item.author?.loginname {
                filtered = name.uppercased().contains(text.uppercased())
            }
            if let title = item.title {
                filtered = title.uppercased().contains(text.uppercased()) || filtered
            }
            return filtered
        }
    }
}
