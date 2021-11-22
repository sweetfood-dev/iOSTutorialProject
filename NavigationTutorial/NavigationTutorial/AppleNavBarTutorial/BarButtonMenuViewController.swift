//
//  BarButtonMenuViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/22.
//

import UIKit

class BarButtonMenuViewController: UIViewController {
    lazy var optionsBarItem: UIBarButtonItem = {
        let rightButton = UIBarButtonItem(title: "Options", style: .plain, target: nil, action: nil)
        return rightButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Bar Button Menu"
        let menu = showMenuBox()
        optionsBarItem.menu = menu
        
        navigationItem.rightBarButtonItem = optionsBarItem
    }
    func menuHandler(action: UIAction) {
        DetailLog.Log("Menu Handler: \(action.title)")
    }
    
    private func showMenuBox() -> UIMenu {
        // title에 문자열을 입력하면 title이 메뉴 상단에 보임
        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc"), handler: menuHandler),
            UIAction(title: "Rename", image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: "Duplicate", image: UIImage(systemName: "plus.square.on.square"), handler: menuHandler),
            UIAction(title: "Move", image: UIImage(systemName: "folder"), handler: menuHandler),
        ])
        return barButtonMenu
    }
}
