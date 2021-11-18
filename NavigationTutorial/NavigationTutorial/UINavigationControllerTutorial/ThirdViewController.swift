//
//  ThirdViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/18.
//

import UIKit

class ThirdViewController: UIViewController, Navigationable {
    static let titleText = "Third View Controller"
    var label: UILabel = {
        let label = UILabel()
        label.text = ThirdViewController.titleText
        label.textAlignment = .center
        return label
    }()
    
    var moveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        
        button.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        return button
    }()
    
    var popToViewControllerButton: UIButton = {
        let button = UIButton()
        button.setTitle("specific viewController", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.sizeToFit()
        button.addTarget(self, action: #selector(popToViewControllerAction), for: .touchUpInside)
        return button
    }()
    
    var popToRootControllerButton: UIButton = {
       let button = UIButton()
        button.setTitle("go Root", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        
        button.addTarget(self, action: #selector(directRootAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setAutoLayout()
        
        view.addSubview(popToViewControllerButton)
        popToViewControllerButton.snp.makeConstraints { make in
            make.height.equalTo(moveButton)
            make.centerX.equalToSuperview()
            make.top.equalTo(moveButton.snp.bottom).offset(10)
        }
        
        view.addSubview(popToRootControllerButton)
        popToRootControllerButton.snp.makeConstraints { make in
            make.height.equalTo(popToViewControllerButton)
            make.leading.trailing.equalTo(moveButton)
            make.top.equalTo(popToViewControllerButton.snp.bottom).offset(10)
        }
    }
    
    @objc func popAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func popToViewControllerAction() {
        guard let viewControllerStack = navigationController?.viewControllers else { return }
        
        viewControllerStack.forEach { viewController in
            if let destination = viewController as? SecondViewController {
                navigationController?.popToViewController(destination, animated: true)
            }
        }
    }
    
    @objc func directRootAction() {
        navigationController?.popToRootViewController(animated: true)
    }
}
