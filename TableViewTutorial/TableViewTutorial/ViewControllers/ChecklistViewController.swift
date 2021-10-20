//
//  ViewController.swift
//  TableViewTutorial
//
//  Created by 권지수 on 2021/10/18.
//

import UIKit
import SnapKit

class ChecklistViewController: UITableViewController {
    var checklist: Checklist!
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(moveNextViewController(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationViewController Title 설정
        setNavigationItem()
    }
        
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheck(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = item.checked ? "√" : ""
    }
}

// MARK: - Segue
extension ChecklistViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
}
// MARK: - Navigation Method
extension ChecklistViewController {
    func setNavigationItem() {
        title = checklist.name
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [addButton]
    }
    // MARK: - Actions
    /// 아이템을 추가하는 AddItemViewController로 이동
    /// - Parameter sender: UIBarButton 인스턴스
    @objc func moveNextViewController(_ sender: UIBarButtonItem){
        // 스토리보드의 AddItemViewController의 식별자로 불러옴
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddItemViewController") as? ItemDetailViewController else { return }
        // AddItemViewController의 델리게이트를 ChecklistViewController로 설정
        vc.delegate = self
        // 네비게이션 컨트롤러로 푸쉬
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - AddItemViewController Delegate
extension ChecklistViewController: ItemDetailViewControllerDelegate {
    /// 아이템이 수정되었을 때 호출
    /// - Parameters:
    ///   - controller: 호출한 VC
    ///   - item: 수정된 ChecklistItem
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    /// 아이템이 추가되었을 때 호출
    /// - Parameters:
    ///   - controller: 호출한 VC
    ///   - item: 추가된 ChecklistItem
    func ItemDetailViewController(_ controller: ItemDetailViewController,
                               didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    /// 추가가 취소되었을 때 호출
    /// - Parameter controller: 호출한 VC
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Tableview Datasource
// TODO: Datasource는 데이터를 가지고 테이블뷰의 행을 관리하는 Delegate
extension ChecklistViewController {
    // 섹션에서 보여줄 총 행의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    // 각 행에 보여줄 데이터를 셀을통해 보여줌
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ChecklistItem 식별자를 가진 셀을 재사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = checklist.items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheck(for: cell, with: item)
        return cell
    }
}

// MARK: - Tableview Delegate
// TODO: 터치, 편집 같은 테이블 뷰 고유 기능의 처리를 관리하는 델리게이트
extension ChecklistViewController {
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.checked.toggle()
            configureCheck(for: cell, with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /// 해당 프로토콜 메서드를 구현하면 스와이프 삭제를 활성화,
    /// - Parameters:
    ///   - tableView: 이 메서드를 호출한 tableView
    ///   - editingStyle: none, delete, insert 3가지
    ///   - indexPath: 이 이벤트를 호출한 행, indexPath
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath
    ) {
        checklist.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}

/*
 Issue1 : 선택을 해제하고 행을 올리다보면 다른행에서 해당 셀을 재사용하기 때문에 체크가 해제되거나 다시 선택되는 경우가 있음
 -> 체크 표시를 표시할지 여부를 기억하기 위해 셀의 액세서리를 사용하는 대신 각 행의 확인 상태를 추적하는 방법이 필요합니다. 즉, 데이터 소스를 확장하고 다음 섹션의 주제인 적절한 데이터 모델을 사용하도록 해야 합니다.
 */
