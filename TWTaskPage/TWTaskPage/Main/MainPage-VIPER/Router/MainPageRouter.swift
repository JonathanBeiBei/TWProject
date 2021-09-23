//
//  MainPageRouter.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import Foundation

class MainPageRouter {
    
    func initialMainPageViewController() -> MainPageViewController {
    //    let interactor = Interactor()
    //    let presenter = Presenter(interactor: interactor)
    //    let tableViewController = TableViewController.instance(withPresenter: presenter)
    //    return tableViewController
        
        let controller = MainPageViewController()
        return controller
    }
}

