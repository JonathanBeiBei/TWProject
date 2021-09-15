//
//  HomePageViewController.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

class HomePageViewController: UIViewController {
    var interactor: HomePageInteractorInterface?
    var router: HomePageRouterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    

}

extension HomePageViewController: HomePageViewControllerInterface {
    
}
