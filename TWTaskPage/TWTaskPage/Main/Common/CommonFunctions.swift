//
//  CommonFunctions.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/16.
//

import Foundation
import UIKit

class CommonFunctions: NSObject {
    //set cornerRadius
    static func setCornerForView(view: UIView,wid: CGFloat,radius: CGFloat,borderColor: UIColor,bgColor: UIColor)  {
         view.layer.borderWidth = wid
         view.layer.borderColor = borderColor.cgColor
         view.layer.cornerRadius = radius
         view.layer.masksToBounds = true
         view.backgroundColor = bgColor
     }
     
     static func setCornerForView(view: UIView,wid: CGFloat,radius: CGFloat,borderColor: UIColor)  {
         view.layer.borderWidth = wid
         view.layer.borderColor = borderColor.cgColor
         view.layer.cornerRadius = radius
         view.layer.masksToBounds = true
     }
    
    static func setViewHei(view: UIView, hei: CGFloat) {
        var viewFrame = view.frame
        viewFrame.size.height = hei
        view.frame = viewFrame
    }
    
    static func setViewWid(view: UIView, wid: CGFloat) {
        var viewFrame = view.frame
        viewFrame.size.width = wid
        view.frame = viewFrame
    }
    
    static func setViewX(view: UIView, x: CGFloat) {
        var viewFrame = view.frame
        viewFrame.origin.x = x
        view.frame = viewFrame
    }
    
    static func setViewY(view: UIView, y: CGFloat) {
        var viewFrame = view.frame
        viewFrame.origin.y = y
        view.frame = viewFrame
    }
    
    static func formatTime(_ time: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SS"
        let date = formatter.date(from: String(time.prefix(19)))
        let dateFormatter = DateFormatter()
        guard let dateTemp = date else {
            return time
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: dateTemp)
    }
    
}
