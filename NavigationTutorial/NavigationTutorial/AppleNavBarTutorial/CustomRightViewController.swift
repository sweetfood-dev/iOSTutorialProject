//
//  CustomRightViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/18.
//

import UIKit
import SnapKit

class CustomRightViewController: UIViewController {
    
    struct ButtonType {
        static let textButton = 0
        static let imageButton = 1
        static let controlButton = 2
    }
    
    lazy var segmentControl: UISegmentedControl = {
       let segmentControl = UISegmentedControl(items: ["Button", "Image", "View"])
        segmentControl.addTarget(self, action: #selector(changeRightBarItem(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupAutoLayout()
        let rightItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(touchAction))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func setupAutoLayout() {
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
    }
    
    @objc func touchAction() {
        print("touche rightButton")
    }
    
    @objc func changeRightBarItem(_ sender: UISegmentedControl) {
        let type = sender.selectedSegmentIndex
        
        switch type {
        case ButtonType.textButton:
            let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(touchAction))
            navigationItem.rightBarButtonItem = addButton
        case ButtonType.imageButton:
            let imageButton = UIBarButtonItem(image: UIImage(systemName: "envelope")!,
                                              style: .plain,
                                              target: self,
                                              action: #selector(touchAction))
            navigationItem.rightBarButtonItem = imageButton
        case ButtonType.controlButton:
            let segmentControl = UISegmentedControl(items: ["Up", "Down"])
            segmentControl.addTarget(self, action: #selector(touchAction), for: .valueChanged)
            segmentControl.isMomentary = true // 선택된 상태 유지하는지의 여부
            let controlButton = UIBarButtonItem(customView: segmentControl)
            segmentControl.snp.makeConstraints { make in
                make.width.equalTo(90)
            }
            navigationItem.rightBarButtonItem = controlButton
            print(segmentControl.frame)
            
        default:
            break
        }
    }
}
