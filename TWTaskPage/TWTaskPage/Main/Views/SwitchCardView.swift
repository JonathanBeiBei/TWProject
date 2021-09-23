//
//  TWSwitchCardView.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//


import SnapKit
import UIKit
import RxSwift
import RxCocoa

protocol SwitchCardViewDelegate: NSObjectProtocol {
    func selectedCard(_ index: Int)
}


class SwitchCardView: UIView {
    
    lazy var leftLabel = UILabel()
    lazy var rightLabel = UILabel()
    lazy var cursorView = UIView()
    lazy var bottomLine = UIView()
    var items: [String]?
    
    weak var delegate: SwitchCardViewDelegate?
    
    private struct Constant {
        static let labelWidth: CGFloat = SCREEN_WIDTH * 0.5
        static let labelHeight: CGFloat = 40
        static let cursorHeight: CGFloat = 3
        static let leftCursorMargin: CGFloat = 16
        static let rightCursorMargin: CGFloat = SCREEN_WIDTH * 0.5 + 16
        static let cursorWidth: CGFloat = SCREEN_WIDTH * 0.5 - 32
        static let bottomLineHeight: CGFloat = 0.5
        static let labelOriginalAlpha: CGFloat = 1
        static let labelDisplayAlpha: CGFloat = 0.6
        static let labelReducedAlpha: CGFloat = 0.4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ frame: CGRect, items: [String]?) {
        self.init(frame: frame)
        self.items = items
        setupViews()
    }
    
    convenience init(items: [String]?) {
        self.init()
        self.items = items
        setupViews()
    }
    
    func setupViews() {
        guard let itemsTemp = self.items,
              itemsTemp.count >= 2 else {
            return
        }
        self.backgroundColor = .white
        
        self.leftLabel = UILabel(frame: CGRect(x: ZERO_SPACE, y: ZERO_SPACE, width: Constant.labelWidth, height: Constant.labelHeight))
        self.addSubview(leftLabel)
        self.leftLabel.text = itemsTemp[0]
        self.leftLabel.textAlignment = .center
        self.leftLabel.textColor = .black

        self.rightLabel = UILabel(frame: CGRect(x: Constant.labelWidth, y: ZERO_SPACE, width: Constant.labelWidth, height: Constant.labelHeight))
        self.addSubview(rightLabel)
        self.rightLabel.text = itemsTemp[1]
        self.rightLabel.textAlignment = .center
        self.rightLabel.textColor = .black
        self.rightLabel.alpha = 0.6

        
        cursorView = UIView(frame: CGRect(x: Constant.leftCursorMargin, y: leftLabel.frame.size.height, width: Constant.cursorWidth, height: Constant.cursorHeight))
        self.addSubview(cursorView)
        self.cursorView.backgroundColor = MainColor

        bottomLine = UIView(frame: CGRect(x: ZERO_SPACE, y: self.frame.size.height - Constant.bottomLineHeight, width: self.frame.size.width, height: Constant.bottomLineHeight))
        self.addSubview(bottomLine)
        self.bottomLine.backgroundColor = MainDark
        
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(clickedLeft))
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(clickedRight))
        leftLabel.isUserInteractionEnabled = true
        rightLabel.isUserInteractionEnabled = true
        leftLabel.addGestureRecognizer(tapLeft)
        rightLabel.addGestureRecognizer(tapRight)
    }
    
    @objc func clickedLeft() {
        self.delegate?.selectedCard(0)
    }
    
    @objc func clickedRight() {
        self.delegate?.selectedCard(1)
    }
    
    func cursorAnimation(_ ifLeft: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            if ifLeft {
                self.leftLabel.alpha = 1
                self.rightLabel.alpha = 0.6
                CommonFunctions.setViewX(view: self.cursorView, x: Constant.leftCursorMargin)
                self.cursorView.center.x = self.leftLabel.center.x
            } else {
                self.leftLabel.alpha = 0.6
                self.rightLabel.alpha = 1
                CommonFunctions.setViewX(view: self.cursorView, x: Constant.rightCursorMargin)
            }
        }, completion: nil)
    }
    
    func moveCursor(_ isLeftScroll: Bool, percentage: CGFloat) {
        self.cursorView.center.x = self.leftLabel.center.x + SCREEN_WIDTH * 0.5 * percentage
        if isLeftScroll {
            leftLabel.alpha = Constant.labelOriginalAlpha - Constant.labelReducedAlpha * percentage
            rightLabel.alpha = Constant.labelDisplayAlpha + Constant.labelReducedAlpha * percentage
        } else {
            rightLabel.alpha = Constant.labelOriginalAlpha - Constant.labelReducedAlpha * (1 - percentage)
            leftLabel.alpha = Constant.labelDisplayAlpha + Constant.labelReducedAlpha * (1 - percentage)
        }
    }
    
}
