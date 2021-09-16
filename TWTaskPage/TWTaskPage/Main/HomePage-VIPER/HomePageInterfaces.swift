//
//  HomePageInterfaces.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

protocol HomePageViewControllerInterface: AnyObject {
    func displaySuccessfulSelectedOneData(_ model: ResultData)
    func displayFailureSelectedOneData()
}

protocol HomePagePresenterInterface {
    func getSuccessfulSelectedOneData(_ model: ResultData)
    func getFailureSelectedOneData()
}

protocol HomePageInteractorInterface {
    func obtainSelectedOneData(requestParameters: [String: Any]?)
}

protocol HomePageRouterInterface {
    
}
