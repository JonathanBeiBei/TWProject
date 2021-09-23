//
//  ScrollPageView.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/16.
//

import UIKit
import MJRefresh

protocol ScrollPageViewDelegate: NSObjectProtocol {
    func loadSelectedData(_ requestParameters: [String: Any])
    func clearSearchText()
}

enum RequestKey: String {
    case Tab = "tab"
    case PageNumber = "page"
    case PageCounts = "limit"
}

enum TableType: String {
    case AskType = "ask"
    case ShareType = "job"
}

class ScrollPageView: UIView {

    var scrollView: UIScrollView!
    var leftTableView: UITableView!
    var rightTableView: UITableView!
    
    // refresh header
    lazy var leftHeader = MJRefreshNormalHeader()
    lazy var rightHeader = MJRefreshNormalHeader()
    // refresh footer
    lazy var leftFooter = MJRefreshAutoNormalFooter()
    lazy var rightFooter = MJRefreshAutoNormalFooter()
    
    private var switchCard: SwitchCardView!
    
    let leftTableViewIdentifier: String = "leftTableViewIdentifier"
    let rightTableViewIdentifier: String = "rightTableViewIdentifier"
    
    weak var delegate: ScrollPageViewDelegate?
    
    var items: [String]?
    var leftDatas: [DataModel]? = []
    var rightDatas: [DataModel]? = []
    var isDisplayLeft = true
    
    private var leftDisplayDatas: [DataModel]? = []
    private var rightDisplayDatas: [DataModel]? = []
    private var leftPageNumber = 1
    private var rightPageNumber = 1
    private var startPointX: CGFloat = 0
    
    
    // if pull up for reloading
    private var isPullUp = false
    
    private struct Constant {
        static let switchCardHeight: CGFloat = 43.5
        // default count in per-page
        static let pageCount = 10
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupView()
    }
    
    convenience init(_ frame: CGRect, items: [String]) {
        self.init(frame: frame)
        self.items = items
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        guard let itemsTemp = self.items,
              itemsTemp.count >= 2 else {
            return
        }
        self.backgroundColor = .white
        
        switchCard = SwitchCardView(CGRect(x: ZERO_SPACE, y: ZERO_SPACE, width: SCREEN_WIDTH, height: Constant.switchCardHeight), items: itemsTemp)
        switchCard.delegate = self
        self.addSubview(switchCard)
        
        scrollView = UIScrollView(frame: CGRect(x: ZERO_SPACE, y: Constant.switchCardHeight, width: SCREEN_WIDTH, height: self.frame.size.height - Constant.switchCardHeight))
        scrollView.delegate = self
        scrollView.bounces  = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: ZERO_SPACE)
        self.addSubview(scrollView)
        setupTableViews()
    }
    
    
    private func setupTableViews() {
        leftTableView = UITableView(frame: CGRect(x: ZERO_SPACE, y: ZERO_SPACE, width: SCREEN_WIDTH, height: self.scrollView.frame.size.height), style: .plain)
        rightTableView = UITableView(frame: CGRect(x: SCREEN_WIDTH, y: ZERO_SPACE, width: SCREEN_WIDTH, height: self.scrollView.frame.size.height), style: .plain)
        leftTableView.delegate = self
        rightTableView.delegate = self
        leftTableView.dataSource = self
        rightTableView.dataSource = self
        leftTableView.tableFooterView = UIView()
        rightTableView.tableFooterView = UIView()
        
        leftTableView.register(HomePageCell.classForCoder(), forCellReuseIdentifier: leftTableViewIdentifier)
//        leftTableView.estimatedRowHeight = 44
//        leftTableView.rowHeight = UITableView.automaticDimension
        rightTableView.register(HomePageCell.classForCoder(), forCellReuseIdentifier: rightTableViewIdentifier)
        
        leftHeader.setRefreshingTarget(self, refreshingAction: #selector(leftHeaderRefresh))
        leftTableView.mj_header = leftHeader
        leftFooter.setRefreshingTarget(self, refreshingAction: #selector(leftFooterRefresh))
        leftTableView.mj_footer = leftFooter
        
        
        rightHeader.setRefreshingTarget(self, refreshingAction: #selector(rightHeaderRefresh))
        rightTableView.mj_header = rightHeader
        rightFooter.setRefreshingTarget(self, refreshingAction: #selector(rightFooterRefresh))
        rightTableView.mj_footer = rightFooter
        
        leftTableView.mj_footer?.state = .pulling
        rightTableView.mj_footer?.state = .pulling
        
        self.scrollView.addSubview(leftTableView)
        self.scrollView.addSubview(rightTableView)
    }
    
    @objc func leftHeaderRefresh() {
        self.isPullUp = false
        self.leftPageNumber = 1
        self.delegate?.loadSelectedData([RequestKey.Tab.rawValue : TableType.AskType.rawValue,
                                            RequestKey.PageNumber.rawValue: self.leftPageNumber,
                                            RequestKey.PageCounts.rawValue: Constant.pageCount])
    }
    
    @objc func leftFooterRefresh() {
        self.isPullUp = true
        self.leftPageNumber += 1
        self.delegate?.loadSelectedData([RequestKey.Tab.rawValue : TableType.AskType.rawValue,
                                            RequestKey.PageNumber.rawValue: self.leftPageNumber,
                                            RequestKey.PageCounts.rawValue: Constant.pageCount])
    }
    
    
    @objc func rightHeaderRefresh() {
        self.isPullUp = false
        self.rightPageNumber = 1
        self.delegate?.loadSelectedData([RequestKey.Tab.rawValue : TableType.ShareType.rawValue,
                                            RequestKey.PageNumber.rawValue: self.rightPageNumber,
                                            RequestKey.PageCounts.rawValue: Constant.pageCount])
    }
    
    @objc func rightFooterRefresh() {
        self.isPullUp = true
        self.rightPageNumber += 1
        self.delegate?.loadSelectedData([RequestKey.Tab.rawValue : TableType.ShareType.rawValue,
                                            RequestKey.PageNumber.rawValue: self.rightPageNumber,
                                            RequestKey.PageCounts.rawValue: Constant.pageCount])
    }
    
    func updateLeftDataAfterObtainingData(_ model: ResponseModel?) {
        if isPullUp {
            guard let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 else {
                leftPageNumber -= 1
                leftTableView.mj_footer?.endRefreshing()
                leftTableView.mj_footer?.state = .noMoreData
                return
            }
            leftDatas?.append(contentsOf: datas)
            leftDisplayDatas = leftDatas
            print("^^ASK^^pull up^^^^^^^^^count:\(String(describing: leftDatas?.count))")
            leftTableView.reloadData()
            leftTableView.mj_footer?.endRefreshing()
        } else {
            if let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 {
                leftDatas?.removeAll()
                leftDatas = datas
                leftDisplayDatas = leftDatas
            }
            print("^^ASK^^pull down^^^^^^^^^count:\(String(describing: leftDatas?.count))")
            leftTableView.reloadData()
            leftTableView.mj_header?.endRefreshing()
            leftTableView.mj_footer?.state = .idle
        }
        delegate?.clearSearchText()
    }
    
    func updateRightDataAfterObtainingData(_ model: ResponseModel?) {
        if isPullUp {
            guard let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 else {
                rightPageNumber -= 1
                rightTableView.mj_footer?.endRefreshing()
                rightTableView.mj_footer?.state = .noMoreData
                return
            }
            rightDatas?.append(contentsOf: datas)
            rightDisplayDatas = rightDatas
            print("^^SHARE^^pull up^^^^^^^^^count:\(String(describing: rightDatas?.count))")
            rightTableView.reloadData()
            rightTableView.mj_footer?.endRefreshing()
        } else {
            if let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 {
                rightDatas?.removeAll()
                rightDatas = datas
                rightDisplayDatas = rightDatas
            }
            print("^^SHARE^^pull down^^^^^^^^^count:\(String(describing: rightDatas?.count))")
            rightTableView.reloadData()
            rightTableView.mj_header?.endRefreshing()
            rightTableView.mj_footer?.state = .idle
        }
        delegate?.clearSearchText()
    }
    
    
    func reloadLeftDataAfterObtainingData(_ model: ResultData?) {
        if isPullUp {
            guard let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 else {
                leftPageNumber -= 1
                leftTableView.mj_footer?.endRefreshing()
                leftTableView.mj_footer?.state = .noMoreData
                return
            }
            leftDatas?.append(contentsOf: datas)
            leftDisplayDatas = leftDatas
            print("^^ASK^^pull up^^^^^^^^^count:\(String(describing: leftDatas?.count))")
            leftTableView.reloadData()
            leftTableView.mj_footer?.endRefreshing()
        } else {
            if let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 {
                leftDatas?.removeAll()
                leftDatas = datas
                leftDisplayDatas = leftDatas
            }
            print("^^ASK^^pull down^^^^^^^^^count:\(String(describing: leftDatas?.count))")
            leftTableView.reloadData()
            leftTableView.mj_header?.endRefreshing()
            leftTableView.mj_footer?.state = .idle
        }
        delegate?.clearSearchText()
    }
    
    func reloadRightDataAfterObtainingData(_ model: ResultData?) {
        if isPullUp {
            guard let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 else {
                rightPageNumber -= 1
                rightTableView.mj_footer?.endRefreshing()
                rightTableView.mj_footer?.state = .noMoreData
                return
            }
            rightDatas?.append(contentsOf: datas)
            rightDisplayDatas = rightDatas
            print("^^SHARE^^pull up^^^^^^^^^count:\(String(describing: rightDatas?.count))")
            rightTableView.reloadData()
            rightTableView.mj_footer?.endRefreshing()
        } else {
            if let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 {
                rightDatas?.removeAll()
                rightDatas = datas
                rightDisplayDatas = rightDatas
            }
            print("^^SHARE^^pull down^^^^^^^^^count:\(String(describing: rightDatas?.count))")
            rightTableView.reloadData()
            rightTableView.mj_header?.endRefreshing()
            rightTableView.mj_footer?.state = .idle
        }
        delegate?.clearSearchText()
    }
    
    func displaySearchResult(_ result: [DataModel]?) {
        if isDisplayLeft {
            leftDisplayDatas = result
            leftTableView.reloadData()
        } else {
            rightDisplayDatas = result
            rightTableView.reloadData()
        }
    }
}

extension ScrollPageView: SwitchCardViewDelegate {
    func selectedCard(_ index: Int) {
        scrollView.setContentOffset(CGPoint(x: Int(SCREEN_WIDTH) * index, y: 0), animated: true)
        
    }
}

extension ScrollPageView: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startPointX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.isKind(of: UITableView.self) {
            // ccroll percentage
            let scrollPercentage = scrollView.contentOffset.x / SCREEN_WIDTH
            let isLeftScroll = (startPointX < scrollView.contentOffset.x) ? true : false
            switchCard.moveCursor(isLeftScroll, percentage: scrollPercentage)
            if scrollPercentage == 0 {
                isDisplayLeft = true
                if self.leftDatas?.count == 0 {
                    self.leftTableView.mj_header?.beginRefreshing()
                }
            }
            if scrollPercentage == 1 {
                isDisplayLeft = false
                if self.rightDatas?.count == 0 {
                    self.rightTableView.mj_header?.beginRefreshing()
                }
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        startPointX = scrollView.contentOffset.x
    }
    
}

extension ScrollPageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftDisplayDatas?.count ?? 0
        } else {
            return rightDisplayDatas?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftTableViewIdentifier, for: indexPath) as! HomePageCell
            let model = self.leftDisplayDatas?[indexPath.row]
            cell.contentModel = model
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: rightTableViewIdentifier, for: indexPath) as! HomePageCell
            let model = self.rightDisplayDatas?[indexPath.row]
            cell.contentModel = model
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        // last section
        let section = tableView.numberOfSections - 1
        if row < 0 || section < 0 {
            return
        }
        let _ = tableView.numberOfRows(inSection: section) - 1
//        if row == lastRow && tableView == leftTableView {
//        }
    }
}
