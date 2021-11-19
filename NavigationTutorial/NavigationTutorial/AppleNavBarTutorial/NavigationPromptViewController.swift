//
//  NavigationPromptViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/19.
//

import UIKit

class NavigationPromptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Navigation Prompt"
        navigationItem.prompt = "Navigation prompts appear at the top"
    }
}
