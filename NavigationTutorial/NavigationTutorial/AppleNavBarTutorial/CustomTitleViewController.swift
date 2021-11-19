//
//  CustomTitleViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/19.
//

import UIKit

class CustomTitleViewController: UIViewController {

    lazy var segmentView: UISegmentedControl = {
       let segment = UISegmentedControl(items: ["Image","Text","Video"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(printTitle), for: .valueChanged)
        segment.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        return segment
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.titleView = segmentView
    }
    
    @objc func printTitle() {
        DetailLog.Log(segmentView.selectedSegmentIndex)
    }
}
