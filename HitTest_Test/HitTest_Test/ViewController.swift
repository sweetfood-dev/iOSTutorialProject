//
//  ViewController.swift
//  HitTest_Test
//
//  Created by todoc on 2021/12/22.
//

import UIKit

class ViewController: UIViewController {

    let viewA = HitTestView()
    let viewB = HitTestView()
    let viewC = HitTestView()
    let viewD = HitTestView()
    let viewE = HitTestView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewA.viewName = "View A"
        viewA.backgroundColor = .blue
        viewB.viewName = "View B"
        viewB.backgroundColor = .brown
        viewC.viewName = "View C"
        viewC.backgroundColor = .brown
        viewD.viewName = "View D"
        viewD.backgroundColor = .systemGray
        viewE.viewName = "View E"
        viewE.backgroundColor = .systemGray
    }
    
    override func viewDidLayoutSubviews() {
        
        let sideMargin:CGFloat = 40
        let betweenViewMargin: CGFloat = 20
        view.addSubview(viewA)
        viewA.frame = view.bounds
        viewA.center = view.center
        
        viewA.addSubview(viewB)
        viewA.addSubview(viewC)
        viewB.frame = CGRect(x: 20,
                             y: 20,
                             width: (viewA.bounds.width - sideMargin * 2 - betweenViewMargin) / 2,
                             height: (viewA.bounds.height - sideMargin * 2))
        
        viewC.frame = CGRect(x: viewB.bounds.width + sideMargin + betweenViewMargin,
                             y: 20,
                             width: (viewA.bounds.width - sideMargin * 2 - betweenViewMargin) / 2,
                             height: (viewA.bounds.height - sideMargin * 2))
        
        viewC.addSubview(viewD)
        viewC.addSubview(viewE)
        
        viewD.frame = CGRect(x: 20, y: 50, width: 150, height: 400)
        viewE.frame = CGRect(x: viewD.frame.width + 20 + 10,
                             y: 50,
                             width: 150,
                             height: 200)
        
        
    }
}

