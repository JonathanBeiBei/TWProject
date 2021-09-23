//
//  MainPageViewController.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import UIKit
import RxSwift

class MainPageViewController: UIViewController {
    
    var presenter: MainPagePresenter?
    
    private let askDisposeBag = DisposeBag()
    private let shareDisposeBag = DisposeBag()
    private var searchBar: UISearchBar?
    private var scrollPageView: ScrollPageView?
    
    private struct Constant {
        static let zeroSpace: CGFloat = 0
        static let searchBarTop: CGFloat = STATUS_BAR_HEIGHT + 5
        static let searchBarLeft: CGFloat = 8
        static let searchBarWidth: CGFloat = SCREEN_WIDTH - 16
        static let searchBarHeight: CGFloat = 40
        static let placeholder = "Search"
        static let emptyString = ""
        static let switchCardData = ["Ask", "Share"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindPresenter()
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
        let keyboardDoneBar = KeyboardDoneBar(frame: CGRect.zero)
        searchBar?.inputAccessoryView = keyboardDoneBar
        keyboardDoneBar.clickDoneClosure {
            self.view.endEditing(true)
        }
        searchBar?.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupScrollPageView() {
        scrollPageView = ScrollPageView(CGRect(x: 0, y: searchBar?.frame.maxY ?? 0 + 8, width: SCREEN_WIDTH, height: self.view.frame.height - (searchBar?.frame.maxY ?? 0 + 8) - TABBAR_HEIGHT), items: Constant.switchCardData)
        view.addSubview(scrollPageView!)
        scrollPageView?.delegate = self
    }
    
    private func bindPresenter() {
        presenter?.askContentUpdated.subscribe(
            onNext: { [weak self] model -> Void in
                self?.scrollPageView?.updateLeftDataAfterObtainingData(model)
            }).disposed(by: askDisposeBag)
        
        presenter?.shareContentUpdated.subscribe(
            onNext: { [weak self] model -> Void in
                self?.scrollPageView?.updateRightDataAfterObtainingData(model)
            }).disposed(by: shareDisposeBag)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespaces)
        if self.scrollPageView?.isDisplayLeft ?? true {
//            self.presenter
//            self.interactor?.searchAction(text, originalData: scrollPageView?.leftDatas)
        } else {
//            self.interactor?.searchAction(text, originalData: scrollPageView?.rightDatas)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}

extension MainPageViewController: ScrollPageViewDelegate {
    func loadSelectedData(_ requestParameters: [String : Any]) {
        presenter?.initializeContentLoad(requestParameters)
    }
    
    func clearSearchText() {
        searchBar?.text = Constant.emptyString
        self.view.endEditing(true)
    }
}
