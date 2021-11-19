//
//  CustomBackButtonImageViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/19.
//

import UIKit

class CustomBackButtonImageViewController: UIViewController {
    let dataSource = CitiesDataSource()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setupNavigationBar()
    }
    
    func setupAutoLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        title = "Cities"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                           target: self,
                                                           action: #selector(dismissViewController))
        
        // 만약 UIBarButtonItem(image: ~~~) 를 사용하면 BackButton의 <가 그대로 출력됨
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationItem.prompt = "The custom back button will appear in the next view controller"
        
        // navigationBar UI설정 관련은 Appearance객체를 이용하자
        let image = UIImage(systemName: "list.bullet")!
        let appearance = UINavigationBarAppearance()
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}

extension CustomBackButtonImageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        let title = dataSource.city(index: indexPath.row)
        vc.view.backgroundColor = .systemGray
        vc.title = "Custom Back Button \(title)"
        navigationController?.pushViewController(vc, animated: true)
    }
}
