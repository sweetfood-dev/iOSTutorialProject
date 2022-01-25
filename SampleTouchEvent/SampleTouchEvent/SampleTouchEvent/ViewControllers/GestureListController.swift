//
//  MainTableViewController.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/24.
//

import UIKit

class GestureListController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        print("viewDidload!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func configuration() {
    }
    
}

// MARK: - TableView DataSource
extension GestureListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GestureList.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableView") {
            cell.textLabel?.text = GestureList.allCases[indexPath.row].rawValue
            return cell
        }else {
            let cell = UITableViewCell(style: .default,
                                       reuseIdentifier: "defaultTableView")
            cell.textLabel?.text = GestureList.allCases[indexPath.row].rawValue
            return cell
        }
    }
}

// MARK: - TableView Delegate
extension GestureListController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        vc.gestureType = GestureList.allCases[indexPath.row]
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
}
