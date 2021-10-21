//
//  AllListViewController.swift
//  TableViewTutorial
//
//  Created by todoc on 2021/10/20.
//

import UIKit

class AllListViewController: UITableViewController {
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(moveDetailViewController))
        return button
    }()
    let cellIdentifier = "ChecklistCell"
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist",
                         sender: checklist)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
// MARK: - Navigation Controller
extension AllListViewController {
    func setNavigationItem() {
        // Title 같은 아이템 단위의 항목에 대한 수정은 navigationItem을 통해,
        // 그외에 title의 크기같은 UI 관련 설정은 navigatioBar를 통해 하는걸로 추측
        navigationItem.title = "Checklists"
        // 큰 제목으로 표시
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func moveDetailViewController() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Navigation ViewController Delegate
extension AllListViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }
}

// MARK: - TableView DataSource
extension AllListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let tmp = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = tmp
        }else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        let count = checklist.countUncheckItems()
        if checklist.items.count == 0 {
            cell.detailTextLabel!.text = "(No Items)"
        }else {
            cell.detailTextLabel!.text = count == 0 ? "All Done" : "\(count) Remaining"
        }
        cell.accessoryType = .detailDisclosureButton
        cell.imageView!.image = UIImage(named: checklist.iconName)
        return cell
    }
}
// MARK: - TableView Delegate
extension AllListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    /// 악세사리 버튼이 탭되었을 때 호출되는 메서드
    /// - Parameters:
    ///   - tableView: 이 메서드를 호출한 tableview
    ///   - indexPath: 이 이벤트를 호출한 행
    override func tableView(_ tableView: UITableView,
                            accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let list = dataModel.lists[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        vc.delegate = self
        vc.checklistToEdit = list
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TableView DataSource
extension AllListViewController {
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}

// MARK: - Segue
extension AllListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let destination = segue.destination as! ChecklistViewController
            destination.checklist = sender as? Checklist
        }else if segue.identifier == "Edithecklist" {
            let destination = segue.destination as! ListDetailViewController
            destination.delegate = self
        }
    }
}

// MARK: - List Detail View Controller Delegates
extension AllListViewController: ListDetailViewControllerDelegate {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishAdding checklist: Checklist) {
        dataModel.lists.append(checklist)
        dataModel.sortChecklists()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishEditing checklist: Checklist) {
        dataModel.sortChecklists()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    
}
