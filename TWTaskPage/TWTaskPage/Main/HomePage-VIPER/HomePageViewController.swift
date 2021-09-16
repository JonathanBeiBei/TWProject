//
//  HomePageViewController.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import SnapKit
import UIKit

class HomePageViewController: UIViewController {
    var interactor: HomePageInteractorInterface?
    var router: HomePageRouterInterface?
    
    private var searchBar: UISearchBar?
    private var switchCard: SwitchCardView?
    
    private struct Constant {
        static let zeroSpace: CGFloat = 0
        static let searchBarTop: CGFloat = STATUS_BAR_HEIGHT + 5
        static let searchBarLeft: CGFloat = 8
        static let searchBarWidth: CGFloat = SCREEN_WIDTH - 16
        static let searchBarHeight: CGFloat = 40
        static let placeholder = "Search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupSearchBar()
        setupSwitchContainer()
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: Constant.searchBarLeft, y: Constant.searchBarTop, width: Constant.searchBarWidth, height: Constant.searchBarHeight))
        view.addSubview(searchBar!)
        searchBar?.placeholder = Constant.placeholder
        searchBar?.delegate = self
        searchBar?.barStyle = .default
        searchBar?.layer.borderWidth = 1
        searchBar?.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupSwitchContainer() {
        switchCard = SwitchCardView(CGRect(x: 0, y: searchBar?.frame.maxY ?? 0 + 8, width: SCREEN_WIDTH, height: 43.5), items: ["Select One", "Select Two"])
        view.addSubview(switchCard!)
    }
}


extension HomePageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked search button")
        searchBar.searchTextField.resignFirstResponder()
    }
}

extension HomePageViewController: HomePageViewControllerInterface {
    
}
