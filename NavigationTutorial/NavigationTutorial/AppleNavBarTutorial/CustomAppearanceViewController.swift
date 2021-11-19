//
//  CustomAppearanceViewController.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/19.
//

import UIKit

class CustomAppearanceViewController: UIViewController {
    lazy var backgroundSwicher: UISegmentedControl = {
       let segmentControl = UISegmentedControl(items: ["Image", "Color"])
        segmentControl.frame = CGRect(x: 0, y: 0, width: 290, height: 33)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    // 이런식으로 UITableViewDataSource 타입의 객체를 별개로 구현하여 테이블뷰의 datasource에 할당하는 방법도 있음!!
    private let dataSource = CitiesDataSource()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        // 어차피 셀 높이는 가변적이지 않아서 필요 없을 것 같음
//        tableView.estimatedRowHeight = UITableView.automaticDimension
//        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = dataSource
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 오토레이아웃 적용
        setupAutoLayout()
        // 네비게이션바, 네비게이션 아이템 설정
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Custom Appearance"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationController?.setToolbarHidden(false, animated: true)
        toolbarItems = [
            UIBarButtonItem.flexibleSpace(),
            UIBarButtonItem(customView: backgroundSwicher),
            UIBarButtonItem.flexibleSpace()
        ]
    }
    
    private func setupAutoLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
