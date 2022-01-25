//
//  HitTestView.swift
//  HitTest_Test
//
//  Created by todoc on 2021/12/22.
//

import UIKit

class HitTestView: UIView {
    var viewName: String = "" {
        didSet {
            let label = UILabel()
            label.text = viewName
            label.font = UIFont.systemFont(ofSize: 20)
            addSubview(label)
            label.center = center
            label.sizeToFit()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event) as? HitTestView
        print("\(viewName): hitTest Result : \(result?.viewName)")
        if result == self { return nil }
        return result
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        print("pointinside: viewName :\(viewName)")
        let reuslt = super.point(inside: point, with: event)
//        print("\(viewName): pointinside Result : \(reuslt)")
        return reuslt
    }
}
