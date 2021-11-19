//
//  MainViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/18.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    enum ViewControllerType: Int {
        case customRightView = 0
        case customTitleView
        case navigationPrompt
        case customAppearance
        case customBackButtonTitles
        case customBackButtonImage
        case largeTitle
        case navigationBarAppearance
        case barButtonItemWithMenu
        
        func presentViewController() -> UIViewController {
            var destinationViewController = UIViewController()
            switch self {
            case .customRightView:
                destinationViewController = CustomRightViewController()
            case .customTitleView:
                destinationViewController = CustomTitleViewController()
            case .navigationPrompt:
                destinationViewController = NavigationPromptViewController()
            case .customAppearance:
                destinationViewController = CustomAppearanceViewController()
            case .customBackButtonTitles:
                destinationViewController.title = "CustomTitle"
                destinationViewController.navigationItem.backButtonTitle = "main"
                destinationViewController.view.backgroundColor = .systemBackground
            case .customBackButtonImage:
                destinationViewController = CustomBackButtonImageViewController()                
            case .largeTitle:
                print("\(self)")
            case .navigationBarAppearance:
                print("\(self)")
            case .barButtonItemWithMenu:
                print("\(self)")
            }
            
            return destinationViewController
        }
    }
    struct ContentsData {
        let title: String
        let detail: String
    }
    
    private lazy var dataModel: [ContentsData] = {
        return createData()
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "NavBar"
        
        let navLeftItem = UIBarButtonItem(title: "Style",
                                          style: .plain,
                                          target: self,
                                          action: #selector(showActionSheet))
        navigationItem.leftBarButtonItem = navLeftItem
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createData() -> [ContentsData] {
        let datas = [ContentsData(title: "Custom Right View", detail: "A navigation bar with a custom control on the right."),
                     ContentsData(title: "Custom Title View", detail: "A navigation bar with a custom control in the center."),
                     ContentsData(title: "Navigation Prompt", detail: "A navigation bar with text added above the title."),
                     ContentsData(title: "Custom Appearance", detail: "A navigation bar with a custom bar tint color and background."),
                     ContentsData(title: "Custom Back Button Titles", detail: "A navigation stack with custom back button titles."),
                     ContentsData(title: "Custom Back Button Image", detail: "A navigation controller with a custom back button image."),
                     ContentsData(title: "Large Title", detail: "A navigation controller with a large title."),
                     ContentsData(title: "Navigation Bar Appearance", detail: "Use of UINavigationBarAppearance and UIBarButtonItemAppearance. "),
                     ContentsData(title: "Bar Button Item with a Menu", detail: "Attach a UIMenu to a UIBarButtonItem. ")]
        
        return datas
        
    }
}

extension MainViewController {
    @objc func showActionSheet() {
        let title = "Choose a UIBarStyle"
        let cancelButtonTitle = "Cancel"
        let defaultButtonTitle = "Default"
        let blackOpaqueTitle = "Black Opaque"
        
        let alertController = UIAlertController(title: title, message: nil,
                                                preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: defaultButtonTitle,
                                                style: .default) { [weak self] _ in
            self?.navigationController?.navigationBar.barStyle = .default
            self?.navigationController?.navigationBar.isTranslucent = true
            self?.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            self?.navigationController?.navigationBar.tintColor = nil
            DetailLog.Log("barStyle: .default")
        })
        
        alertController.addAction(UIAlertAction(title: blackOpaqueTitle,
                                                style: .default) { [weak self] _ in
            self?.navigationController?.navigationBar.barStyle = .black
            self?.navigationController?.navigationBar.isTranslucent = false
            self?.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            DetailLog.Log("barStyle: .black")
        })
        
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let viewControllerType = ViewControllerType.init(rawValue: row)!
        switch viewControllerType {
        case .customAppearance, .customBackButtonImage:
            let destinationNavigationController = UINavigationController(rootViewController: viewControllerType.presentViewController())
            present(destinationNavigationController, animated: true, completion: nil)
        default:
            navigationController?.pushViewController(viewControllerType.presentViewController(), animated: true)
        }
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell")
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: "mainCell")
        let row = indexPath.row
        cell.textLabel?.text = dataModel[row].title
        cell.detailTextLabel?.text = dataModel[row].detail
        
        return cell
    }
    
    
}
