//
//  ViewController.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/01.
//

import UIKit
import SnapKit

enum SectionType: String, CaseIterable {
    case addNew = "추가"
    case category = "분류"
    
    var height: CGFloat {
        switch self {
        case .addNew:
            return 0
        case .category:
            return 60
        }
    }
}

class ChecklistViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.separatorStyle = .singleLine
        tv.separatorColor = .opaqueSeparator
        tv.separatorInsetReference = .fromAutomaticInsets
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UITableView.automaticDimension
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        addSubViews()
        setTableView()
        setAutoLayout()
    }
    private func setNavigationBar() {
        title = "Category"
        self.navigationItem.rightBarButtonItem = editButtonItem
    }
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "\(ChecklistHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: ChecklistHeaderView.identifier)
        
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChecklistHeaderView.identifier) as? ChecklistHeaderView else {
            print("headerView is nil")
            return nil
        }
        
        headerView.titleLabel.text = SectionType.allCases[section].rawValue
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let index = indexPath.row
        
        if section == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "\(AddNewListViewController.self)") as! AddNewListViewController
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        let item = DataManager.items[index]
        let vc = storyboard?.instantiateViewController(withIdentifier: ContentsListViewController.storyboardIdentifier) as! ContentsListViewController
        vc.category = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - TableView DataSource
extension ChecklistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return SectionType.allCases[section].height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : DataManager.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let index = indexPath.row
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddHeader") ?? UITableViewCell(style: .default, reuseIdentifier: "AddHeader")
            cell.textLabel?.text = SectionType.allCases[section].rawValue
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = CheckListCell.dequeueReusableCell(tableView)
            let item = DataManager.items[index]
            return cell.configure(item)
        }
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
