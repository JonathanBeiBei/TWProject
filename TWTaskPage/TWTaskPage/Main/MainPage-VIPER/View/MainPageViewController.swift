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
    private let filterDisposeBag = DisposeBag()
    private var searchBar: UISearchBar?
    private var scrollPageView: ScrollPageView?
    
    private struct Constant {
        static let zeroSpace: CGFloat = 0
        static let borderWidth: CGFloat = 1
        static let searchBarTop: CGFloat = STATUS_BAR_HEIGHT + 5
        static let searchBarLeft: CGFloat = 8
        static let searchBarWidth: CGFloat = SCREEN_WIDTH - 16
        static let searchBarHeight: CGFloat = 40
        static let defaultMargin: CGFloat = 8
        static let placeholder = "Search"
        static let emptyString = ""
        static let switchCardData = ["Ask", "Share"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        searchBar?.layer.borderWidth = Constant.borderWidth
        let keyboardDoneBar = KeyboardDoneBar(frame: CGRect.zero)
        searchBar?.inputAccessoryView = keyboardDoneBar
        keyboardDoneBar.clickDoneClosure {
            self.view.endEditing(true)
        }
        searchBar?.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupScrollPageView() {
        scrollPageView = ScrollPageView(
            CGRect(x: Constant.zeroSpace,
                   y: searchBar?.frame.maxY ?? Constant.zeroSpace + Constant.defaultMargin,
                   width: SCREEN_WIDTH,
                   height: self.view.frame.height - (searchBar?.frame.maxY ?? Constant.zeroSpace + Constant.defaultMargin) - TABBAR_HEIGHT),
            items: Constant.switchCardData)
        
        view.addSubview(scrollPageView!)
        scrollPageView?.delegate = self
    }
    
    private func observePresenter() {
        presenter?.askContentObservable?.subscribe(
            onNext: { model in
                self.scrollPageView?.updateLeftDataAfterObtainingData(model)
            }, onError: { _ in
                self.scrollPageView?.updateLeftDataAfterObtainingData(nil)
            }
        ).disposed(by: askDisposeBag)
        
        presenter?.shareContentObservable?.subscribe(
            onNext: { model in
                self.scrollPageView?.updateRightDataAfterObtainingData(model)
            }, onError: { _ in
                self.scrollPageView?.updateRightDataAfterObtainingData(nil)
            }
        ).disposed(by: shareDisposeBag)
        
        presenter?.filterContentUpdated.subscribe(
            onNext: { [weak self] models in
                self?.scrollPageView?.displaySearchResult(models)
            }
        ).disposed(by: filterDisposeBag)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespaces)
        if self.scrollPageView?.isDisplayLeft ?? true {
            presenter?.searchActions(text, originalData: scrollPageView?.leftDatas)
        } else {
            presenter?.searchActions(text, originalData: scrollPageView?.rightDatas)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}

extension MainPageViewController: ScrollPageViewDelegate {
    func loadSelectedData(_ requestParameters: [String : Any]) {
        presenter?.loadDisplayContents(requestParameters)
        observePresenter()
    }
    
    func clearSearchText() {
        searchBar?.text = Constant.emptyString
        self.view.endEditing(true)
    }
}
