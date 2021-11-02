//
//  AddNewListViewController.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/02.
//

import UIKit

class AddNewListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setAutoLayout()
    }
    
    private func addSubViews() {
    }
    
    private func setAutoLayout() {
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct AddNewListViewController_Preview: PreviewProvider {
    static var previews: some View {
        AddNewListViewController().showPreview()
    }
}
#endif

