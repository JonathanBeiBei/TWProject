//
//  HomePageConfigurtor.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

class HomePageConfigurtor: NSObject {
    
    @objc class func configurateViewController() -> UIViewController {
        let viewController = HomePageViewController()
        let interactor = HomePageInteractor()
        let presenter = HomePagePresenter()
        let router = HomePageRouter()
        let worker = HomePageWorker()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
      
}
