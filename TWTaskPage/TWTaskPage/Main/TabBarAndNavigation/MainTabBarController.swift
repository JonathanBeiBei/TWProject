//
//  ViewController.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

class MainTabBarController: UITabBarController {

    var homeNavigationController: MainNavigationController?
    var meNavigationController: MainNavigationController?
    
    private struct Constant {
        static let barHomeGray = "bar_home_gray"
        static let barHomeLight = "bar_home_light"
        static let barMeGray = "bar_me_gray"
        static let barMeLight = "bar_me_light"
        static let homeTitle = "Home"
        static let meTitle = "Me"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        setupView()
    }
    
    private func setupView() {
        self.tabBar.tintColor = MainColor
        self.tabBar.unselectedItemTintColor = MainDark
        
        let homeController = HomePageConfigurtor.configurateViewController()
        homeNavigationController = MainNavigationController(rootViewController: homeController)
        
        homeNavigationController?.tabBarItem.title = Constant.homeTitle
        var homeImage = UIImage(named: Constant.barHomeGray)
        var homeSelectedImage = UIImage(named: Constant.barHomeLight)
        homeImage = homeImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        homeSelectedImage = homeSelectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        homeNavigationController?.tabBarItem.image = homeImage
        homeNavigationController?.tabBarItem.selectedImage = homeSelectedImage
        
        
        let meController = MainPageConfigurator.initialMainPageViewController()
        meNavigationController = MainNavigationController(rootViewController: meController)
        meNavigationController?.tabBarItem.title = Constant.meTitle
        var meImage = UIImage(named: Constant.barMeGray)
        var meSelectedImage = UIImage(named: Constant.barMeLight)
        
        meImage = meImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        meSelectedImage = meSelectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        meNavigationController?.tabBarItem.image = meImage
        meNavigationController?.tabBarItem.selectedImage = meSelectedImage
        
        self.viewControllers = [homeNavigationController ?? UINavigationController(), meNavigationController ?? UINavigationController()]
    }

}


extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
