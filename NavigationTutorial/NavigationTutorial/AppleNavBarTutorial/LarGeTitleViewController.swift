//
//  LarGeTitleViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/22.
//

import UIKit

class LarGeTitleViewController: UIViewController{
    let dataSource = CitiesDataSource()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.delegate = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAutolayOut()
        setNavigation()
    }
    
    private func setupAutolayOut() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func setNavigation() {
        title = "Large Title"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let leftItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(popAction))
        navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func popAction() {
        dismiss(animated: true, completion: nil)
    }
}


extension LarGeTitleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = dataSource.city(index: indexPath.row)
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.title = title
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
