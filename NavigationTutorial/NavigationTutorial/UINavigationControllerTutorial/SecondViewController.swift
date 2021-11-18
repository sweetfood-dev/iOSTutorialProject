//
//  SecondViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/17.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController, Navigationable {
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "SeconViewController"
        label.textAlignment = .center
        return label
    }()
    
    lazy var moveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitle("move", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 2
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        title = "SecondViewController"
        view.backgroundColor = .systemGreen        
        setAutoLayout()
    }
    
    @objc func pushAction() {
        let destination = ThirdViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
}
