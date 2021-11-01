//
//  ViewController.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/01.
//

import UIKit
import SnapKit

class ChecklistViewController: UIViewController {
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
        
        addSubViews()
        setTableView()
        setAutoLayout()
    }
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        CheckListCell.register(tableView)
    }
    private func setAutoLayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - TableView Delegate
extension ChecklistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DidSelect \(indexPath.row) row")
    }
}
// MARK: - TableView DataSource
extension ChecklistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CheckItem.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CheckListCell.dequeueReusableCell(tableView)
        
        let item = CheckItem.items[indexPath.row]
        return cell.configure(item)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewContollrer_Preview: PreviewProvider {
    static var previews: some View {
        ChecklistViewController().showPreview()
    }
}
#endif
