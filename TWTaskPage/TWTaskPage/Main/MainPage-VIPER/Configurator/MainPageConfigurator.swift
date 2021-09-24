//
//  MainPageConfigurator.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/24.
//

import UIKit

class MainPageConfigurator: NSObject {
    
    static func initialMainPageViewController() -> MainPageViewController {
        let interactor = MainPageInteractor()
        let presenter = MainPagePresenter(interactor: interactor)
        let controller = MainPageViewController()
        controller.presenter = presenter
        return controller
    }
    
}
