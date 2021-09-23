//
//  KeyboardDoneBar.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import UIKit

class KeyboardDoneBar: UIToolbar {

    typealias clickDoneButtonClosure = () -> ()
    var clickClosure: clickDoneButtonClosure?
    // setup invoked function for ‘clickClosure’
    func clickDoneClosure(closure: clickDoneButtonClosure?) {
        clickClosure = closure
    }
    
    private struct Constants {
        static let toolBarHeight: CGFloat = 36.0
        static let buttonText = "Done"
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: Constants.toolBarHeight))
        sutupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sutupView() {
        self.backgroundColor = UIColor.gray
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: Constants.buttonText, style: .plain, target: self, action: #selector(doneClick))
        self.items = [spaceBtn, doneBtn]
        self.sizeToFit()
    }
    
    @objc func doneClick() {
        guard let closure = clickClosure else {
            return
        }
        closure()
    }

}
