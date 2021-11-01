//
//  UITableVIewCell+Registerable.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/01.
//

import UIKit

protocol UITableViewRegisterable {
    static var reuseIdentifier: String { get }
    static func register(_ tableView: UITableView)
    static func dequeueReusableCell(_ tableView: UITableView) -> Self
}

extension UITableViewRegisterable where Self: UITableViewCell {
    static var reuseIdentifier: String { "\(self)" }
    
    static func register(_ tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    static func dequeueReusableCell(_ tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            fatalError("TableView dequeue cell error identifier : \(reuseIdentifier)")
        }
        return cell as! Self
    }
}
