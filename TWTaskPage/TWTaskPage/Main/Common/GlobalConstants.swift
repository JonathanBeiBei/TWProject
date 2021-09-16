//
//  GlobalConstants.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit

let MainColor = UIColor.init(21, 185, 152)
let MainDark = UIColor.init(125, 125, 125)

// MARK: width - height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
// status bar height
let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.height
// tabbar height
let TABBAR_HEIGHT = CGFloat((STATUS_BAR_HEIGHT >= 44 ? 83 : 49))

let ZERO_SPACE: CGFloat = 0
