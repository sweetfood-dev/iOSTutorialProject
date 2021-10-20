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
    var lists = [Checklist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        loadChecklist()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}
// MARK: - Documents
extension AllListViewController {
    func loadChecklist() {
        // Add placeholder data
         var list = Checklist(name: "Birthdays")
         lists.append(list)

         list = Checklist(name: "Groceries")
         lists.append(list)

         list = Checklist(name: "Cool Apps")
         lists.append(list)

         list = Checklist(name: "To Do")
         lists.append(list)
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

// MARK: - TableView DataSource
extension AllListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let checklist = lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
}
// MARK: - TableView Delegate
extension AllListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    /// 악세사리 버튼이 탭되었을 때 호출되는 메서드
    /// - Parameters:
    ///   - tableView: 이 메서드를 호출한 tableview
    ///   - indexPath: 이 이벤트를 호출한 행
    override func tableView(_ tableView: UITableView,
                            accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let list = lists[indexPath.row]
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
        lists.remove(at: indexPath.row)
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
        let index = lists.count
        let indexPath = IndexPath(row: index, section: 0)
        let indexPaths = [indexPath]
        lists.append(checklist)
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishEditing checklist: Checklist) {
        if let index = lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
