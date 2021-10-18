//
//  ViewController.swift
//  TableViewTutorial
//
//  Created by 권지수 on 2021/10/18.
//

import UIKit
import SnapKit

class ChecklistViewController: UITableViewController {
    /// Checklist의 데이터 모델
    var items = [ChecklistItem]()
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(moveNextViewController(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationViewController Title 설정
        setNavigationItem()
        
        // Replace previous code with the following
        let item1 = ChecklistItem()
        item1.text = "Walk the dog"
        items.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "Brush my teeth"
        item2.checked = true
        items.append(item2)
        
        let item3 = ChecklistItem()
        item3.text = "Learn iOS development"
        item3.checked = true
        items.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "Soccer practice"
        items.append(item4)
        
        let item5 = ChecklistItem()
        item5.text = "Eat ice cream"
        items.append(item5)
    }
        
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheck(for cell: UITableViewCell, with item: ChecklistItem) {
        cell.accessoryType = item.checked ? .checkmark : .none
    }
}
// MARK: - Navigation Method
extension ChecklistViewController {
    func setNavigationItem() {
        // Title 같은 아이템 단위의 항목에 대한 수정은 navigationItem을 통해,
        // 그외에 title의 크기같은 UI 관련 설정은 navigatioBar를 통해 하는걸로 추측
        navigationItem.title = "CheckList"
        // 큰 제목으로 표시
        navigationController?.navigationBar.prefersLargeTitles = true
        // .append(_:)를 사용하면 추가가 안되는듯?
        navigationItem.rightBarButtonItems = [addButton]
    }
    // MARK: - Actions
    /// 1. 새로운 CheckList 아이템을 만들고
    /// 2. 데이터 모델 items에 추가한 후
    /// 3. 테이블 뷰의 새로운 행에 생성한 아이템을 추가
    /// - Parameter sender: UIBarButton 인스턴스
    @objc func addItem(_ sender: UIBarButtonItem) {
        let newRowIndex = items.count
        // 새로운 아이템 생성 후 추가
        let item = ChecklistItem()
        item.text = "i am new row"
        item.checked = true
        items.append(item)
        
        // IndexPath 설정, 현재 section이 하나이기에 section은 0
        // row: 마지막 row에 들어가야하기에 newRowIndex는 items.count
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        // Array 생성
        let indexPaths = [indexPath]
        // indexPaths에 새로 추가한 인덱스 경로들을 tableView에게 삽입하고 업데이트하라고 알림!
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    /// 아이템을 추가하는 AddItemViewController로 이동
    /// - Parameter sender: UIBarButton 인스턴스
    @objc func moveNextViewController(_ sender: UIBarButtonItem){
        // 스토리보드의 AddItemViewController의 식별자로 불러옴
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddItemViewController") as? AddItemViewController else { return }
        // AddItemViewController의 델리게이트를 ChecklistViewController로 설정
        vc.delegate = self
        // 네비게이션 컨트롤러로 푸쉬
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - AddItemViewController Delegate
extension ChecklistViewController: AddItemViewControllerDelegate {
    func addItemViewController(_ controller: AddItemViewController,
                               didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Tableview Datasource
// TODO: Datasource는 데이터를 가지고 테이블뷰의 행을 관리하는 Delegate
extension ChecklistViewController {
    // 섹션에서 보여줄 총 행의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    // 각 행에 보여줄 데이터를 셀을통해 보여줌
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ChecklistItem 식별자를 가진 셀을 재사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
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
            let item = items[indexPath.row]
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
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}

/*
 Issue1 : 선택을 해제하고 행을 올리다보면 다른행에서 해당 셀을 재사용하기 때문에 체크가 해제되거나 다시 선택되는 경우가 있음
 -> 체크 표시를 표시할지 여부를 기억하기 위해 셀의 액세서리를 사용하는 대신 각 행의 확인 상태를 추적하는 방법이 필요합니다. 즉, 데이터 소스를 확장하고 다음 섹션의 주제인 적절한 데이터 모델을 사용하도록 해야 합니다.
 */
