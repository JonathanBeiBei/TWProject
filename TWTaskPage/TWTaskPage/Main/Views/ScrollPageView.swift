//
//  ScrollPageView.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/16.
//

import UIKit

protocol ScrollPageViewDelegate: NSObjectProtocol {
    func loadSelectedOneData(_ pageNumber: Int, pageCount: Int)
}

class ScrollPageView: UIView {

    var scrollView: UIScrollView!
    var leftTableView: UITableView!
    var rightTableView: UITableView!
    
    lazy var leftRefreshControl = UIRefreshControl()
    lazy var rightRefreshControl = UIRefreshControl()
    private var switchCard: SwitchCardView!
    
    
    let leftTableViewIdentifier: String = "leftTableViewIdentifier"
    let rightTableViewIdentifier: String = "rightTableViewIdentifier"
    
    weak var delegate: ScrollPageViewDelegate?
    
    lazy var leftDatas: [DataDictionary]? = []
    var pageNumber = 1
    private let pageCount = 6
    
    
    private var items: [String]?
    // if pull up for reloading
    var isPullUp = false
    
    private struct Constant {
        static let switchCardHeight: CGFloat = 43.5
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
        leftTableView.tableFooterView = nil
        rightTableView.tableFooterView = nil
        
        leftTableView.register(ItemCell.classForCoder(), forCellReuseIdentifier: leftTableViewIdentifier)
        leftTableView.estimatedRowHeight = 44
        leftTableView.rowHeight = UITableView.automaticDimension
        leftTableView.separatorStyle = .none
        leftTableView.showsVerticalScrollIndicator = false
        rightTableView.register(ItemCell.classForCoder(), forCellReuseIdentifier: rightTableViewIdentifier)
        
//        leftRefreshControl.backgroundColor = .systemGroupedBackground
//        leftRefreshControl.tintColor = UIColor.gray
        leftRefreshControl.addTarget(self, action: #selector(reloadLeftData), for: .valueChanged)
        rightRefreshControl.addTarget(self, action: #selector(reloadRightData), for: .valueChanged)
        leftTableView.addSubview(leftRefreshControl)
        
        rightTableView.addSubview(rightRefreshControl)
        
        self.scrollView.addSubview(leftTableView)
        self.scrollView.addSubview(rightTableView)
    }
    
    @objc func reloadLeftData(_ number: Int = 1) {
        if self.isPullUp {
            // append data
//            leftTableView.refreshControl?.beginRefreshing()
            
        } else {
            // clear firstly, then add data
            self.pageNumber = 1
            self.delegate?.loadSelectedOneData(self.pageNumber, pageCount: pageCount)
        }
        
//        isPullUp = false
//        self.leftRefreshControl.endRefreshing()
//        leftTableView.reloadData()
    }
    
    @objc func reloadRightData() {
        if self.isPullUp {
            // append data
            
        } else {
            // clear firstly, then add data
        }
        isPullUp = false
        self.rightRefreshControl.endRefreshing()
        rightTableView.reloadData()
    }
    
    
    func reloadLeftDataAfterObtainingData(_ model: ResultData?) {
        if isPullUp {
            isPullUp = false
        } else {
            if let modelTemp = model,
               let datas = modelTemp.data,
               datas.count > 0 {
                leftDatas?.removeAll()
                leftDatas = datas
            }
        }
        leftRefreshControl.endRefreshing()
        leftTableView.reloadData()
        
    }
}

extension ScrollPageView: SwitchCardViewDelegate {
    func selectedCard(_ index: Int) {
        scrollView.setContentOffset(CGPoint(x: Int(SCREEN_WIDTH) * index, y: 0), animated: true)
    }
}

extension ScrollPageView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.isKind(of: UITableView.self) {
            print("^^^^^^^:\(scrollView.contentOffset.x)")
            let index = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
            // update switchCard
            switchCard.switchStatus(index)
        }
    }
    
}

extension ScrollPageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftDatas?.count ?? 0
        } else {
            return 20
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftTableViewIdentifier, for: indexPath) as! ItemCell
            let model = self.leftDatas?[indexPath.row]
            cell.titleLab.text = model?.title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: rightTableViewIdentifier, for: indexPath) as! ItemCell
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
        let lastRow = tableView.numberOfRows(inSection: section) - 1
        if row == lastRow && tableView == leftTableView {
            isPullUp = true
//            reloadLeftData()
        }
        if row == lastRow && tableView == rightTableView {
            isPullUp = true
//            reloadLeftData()
        }
    }
}
