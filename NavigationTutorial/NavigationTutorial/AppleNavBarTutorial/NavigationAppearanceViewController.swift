//
//  NavigationAppearanceViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/22.
//

import UIKit

class NavigationAppearanceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        title = "Appearance"
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .systemRed
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        
        let rightButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightButton
        let rightAppearance = UIBarButtonItemAppearance()
        rightAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
        barAppearance.doneButtonAppearance = rightAppearance
        
        let leftAppearance = UIBarButtonItemAppearance()
        leftAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.green]
        barAppearance.buttonAppearance = leftAppearance
        
        navigationItem.standardAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
        
    }
}
