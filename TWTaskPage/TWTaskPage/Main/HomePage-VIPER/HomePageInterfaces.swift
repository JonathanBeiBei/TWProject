//
//  HomePageInterfaces.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

protocol HomePageViewControllerInterface: AnyObject {
    func displaySuccessfulTabAskData(_ model: ResultData)
    func displayFailureTabAskData()
    
    func displaySuccessfulTabShareData(_ model: ResultData)
    func displayFailureTabShareData()
    
    func displaySearchResult(_ result: [DataModel]?)
}

protocol HomePagePresenterInterface {
    func getSuccessfulTabAskData(_ model: ResultData)
    func getFailureTabAskData()
    
    func getSuccessfulTabShareData(_ model: ResultData)
    func getFailureTabShareData()
    
    func searchResult(_ result: [DataModel]?) 
}

protocol HomePageInteractorInterface {
    func obtainSelectedOneData(requestParameters: [String: Any]?)
    
    func searchAction(_ text: String, originalData: [DataModel]?)
}

protocol HomePageRouterInterface {
    
}
