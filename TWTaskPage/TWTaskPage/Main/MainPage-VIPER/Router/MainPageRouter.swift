//
//  MainPageRouter.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import Foundation

class MainPageRouter {
    
    func initialMainPageViewController() -> MainPageViewController {
        let interactor = MainPageInteractor()
        let presenter = MainPagePresenter(interactor: interactor)
        let controller = MainPageViewController()
        controller.presenter = presenter
        return controller
    }
}

