//
//  UITableViewRegisterable.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/29.
//

import UIKit

protocol UITableViewRegisterable{
    static var useNibFile: Bool { get }
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
    static func register(tableView: UITableView)
    static func dequeueReusableCell(tableView: UITableView) -> Self
}


extension UITableViewRegisterable where Self: UITableViewCell {
    static var useNibFile: Bool {
        return false
    }
    static var nibName: String {
        return "\(self)"
    }
    static var reuseIdentifier: String {
        return "\(self)"
    }
    static func register(tableView: UITableView) {
        if useNibFile {
            tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        }else {
            tableView.register(Self.self, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    static func dequeueReusableCell(tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            fatalError("dequeCell Error Identifier : \(reuseIdentifier)")
        }
        
        return cell as! Self
    }
}
