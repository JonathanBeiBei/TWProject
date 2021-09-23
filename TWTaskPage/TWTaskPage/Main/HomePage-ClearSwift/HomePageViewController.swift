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
    private var scrollPageView: ScrollPageView?
    private var doneButton: KeyboardDoneUtils?
    
    private struct Constant {
        static let zeroSpace: CGFloat = 0
        static let searchBarTop: CGFloat = STATUS_BAR_HEIGHT + 5
        static let searchBarLeft: CGFloat = 8
        static let searchBarWidth: CGFloat = SCREEN_WIDTH - 16
        static let searchBarHeight: CGFloat = 40
        static let placeholder = "Search"
        static let switchCardData = ["Ask", "Share"]
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
        setupScrollPageView()
        scrollPageView?.leftTableView.mj_header?.beginRefreshing()
    }
    
    
    private func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: Constant.searchBarLeft, y: Constant.searchBarTop, width: Constant.searchBarWidth, height: Constant.searchBarHeight))
        view.addSubview(searchBar!)
        searchBar?.placeholder = Constant.placeholder
        searchBar?.delegate = self
        searchBar?.barStyle = .default
        searchBar?.layer.borderWidth = 1
        doneButton = KeyboardDoneUtils.shard
        searchBar?.inputAccessoryView = doneButton?.doneToolBar()
        doneButton?.delegate = self
        searchBar?.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupScrollPageView() {
        scrollPageView = ScrollPageView(CGRect(x: 0, y: searchBar?.frame.maxY ?? 0 + 8, width: SCREEN_WIDTH, height: self.view.frame.height - (searchBar?.frame.maxY ?? 0 + 8) - TABBAR_HEIGHT), items: Constant.switchCardData)
        view.addSubview(scrollPageView!)
        scrollPageView?.delegate = self
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension HomePageViewController: ScrollPageViewDelegate {
    func clearSearchText() {
        searchBar?.text = ""
        self.view.endEditing(true)
    }
    
    func loadSelectedData(_ requestParameters: [String: Any]) {
        self.interactor?.obtainSelectedOneData(requestParameters: requestParameters)
    }
}

extension HomePageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespaces)
        if self.scrollPageView?.isDisplayLeft ?? true {
            self.interactor?.searchAction(text, originalData: scrollPageView?.leftDatas)
        } else {
            self.interactor?.searchAction(text, originalData: scrollPageView?.rightDatas)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}

extension HomePageViewController: ClickDoneDelegate {
    func clickDoneInKeyboard() {
        self.view.endEditing(true)
    }
}

extension HomePageViewController: HomePageViewControllerInterface {
    
    func displaySuccessfulTabAskData(_ model: ResultData) {
        scrollPageView?.reloadLeftDataAfterObtainingData(model)
    }
    func displayFailureTabAskData() {
        scrollPageView?.reloadLeftDataAfterObtainingData(nil)
    }
    
    func displaySuccessfulTabShareData(_ model: ResultData) {
        scrollPageView?.reloadRightDataAfterObtainingData(model)
    }
    
    func displayFailureTabShareData() {
        scrollPageView?.reloadRightDataAfterObtainingData(nil)
    }
    func displaySearchResult(_ result: [DataModel]?) {
        scrollPageView?.displaySearchResult(result)
    }
}
