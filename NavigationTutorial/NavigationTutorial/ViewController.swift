//
//  ViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/17.
//

import UIKit

class ViewController: UIViewController, Navigationable {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "MainViewController"
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
        
        title = "ab"
        view.backgroundColor = .white
        setAutoLayout()
    }
    
    @objc func pushAction() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
}

