//
//  ContentsListViewController.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/02.
//

import UIKit

class ContentsListViewController: UIViewController {
    static let storyboardIdentifier: String = "ContentsListViewController"
    
    var category: CheckItem?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.separatorStyle = .singleLine
        tv.separatorColor = .opaqueSeparator
        tv.separatorInsetReference = .fromAutomaticInsets
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UITableView.automaticDimension
        
        
        // 임시로 회색
        tv.backgroundColor = .systemGray
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        addSubViews()
        setAutoLayout()
        setTableView()
    }
    private func setNavigationBar() {
        title = category?.title
//        navigationItem.rightBarButtonItem = editButtonItem
    }
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setAutoLayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ContentsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ContentsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") ?? UITableViewCell(style: .default, reuseIdentifier: "testCell")
        cell.textLabel?.text = category?.title
        cell.selectionStyle = .none
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ContentsListViewController_Preview: PreviewProvider {
    static var previews: some View {
        ContentsListViewController().showPreview()
    }
}
#endif

