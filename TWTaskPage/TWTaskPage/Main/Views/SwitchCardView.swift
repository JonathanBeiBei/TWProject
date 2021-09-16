//
//  TWSwitchCardView.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//


import SnapKit
import UIKit

class SwitchCardView: UIView {
    
    lazy var leftLabel = UILabel()
    lazy var rightLabel = UILabel()
    lazy var cursorView = UIView()
    lazy var bottomLine = UIView()
    var items: [String]?
    
    private struct Constant {
        static let labelWidth: CGFloat = SCREEN_WIDTH * 0.5
        static let labelHeight: CGFloat = 40
        static let cursorHeight: CGFloat = 3
        static let leftCursorMargin: CGFloat = 16
        static let rightCursorMargin: CGFloat = SCREEN_WIDTH * 0.5 + 16
        static let cursorWidth: CGFloat = SCREEN_WIDTH * 0.5 - 32
        static let bottomLineHeight: CGFloat = 0.5
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
        self.leftLabel.textColor = MainDark

        self.rightLabel = UILabel(frame: CGRect(x: Constant.labelWidth, y: ZERO_SPACE, width: Constant.labelWidth, height: Constant.labelHeight))
        self.addSubview(rightLabel)
        self.rightLabel.text = itemsTemp[1]
        self.rightLabel.textAlignment = .center
        self.rightLabel.textColor = MainDark

        
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
        cursorAnimation(true)
    }
    
    
    @objc func clickedRight() {
        cursorAnimation(false)
    }
    
    func cursorAnimation(_ ifLeft: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            if ifLeft {
                self.cursorView.center.x = self.leftLabel.center.x
            } else {
                self.cursorView.center.x = self.rightLabel.center.x
            }
        }, completion: nil)
    }
    
}
