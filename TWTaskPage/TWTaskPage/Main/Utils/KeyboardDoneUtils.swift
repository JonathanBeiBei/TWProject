//
//  KeyboardDoneUtils.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/22.
//

import UIKit

protocol ClickDoneDelegate: NSObjectProtocol {
    func clickDoneInKeyboard()
}

class KeyboardDoneUtils: NSObject {

    weak var delegate: ClickDoneDelegate?

    static let shard = KeyboardDoneUtils()
    
    func doneToolBar() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 36.0))
        toolBar.backgroundColor = UIColor.gray
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        toolBar.items = [spaceBtn, doneBtn]
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc func doneClick() {
        self.delegate?.clickDoneInKeyboard()
    }
}

