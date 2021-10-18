//
//  ViewController.swift
//  TableViewTutorial
//
//  Created by 권지수 on 2021/10/18.
//

import UIKit

class ChecklistViewController: UITableViewController {
    /// Checklist의 데이터 모델
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

/*
 Issue1 : 선택을 해제하고 행을 올리다보면 다른행에서 해당 셀을 재사용하기 때문에 체크가 해제되거나 다시 선택되는 경우가 있음
 -> 체크 표시를 표시할지 여부를 기억하기 위해 셀의 액세서리를 사용하는 대신 각 행의 확인 상태를 추적하는 방법이 필요합니다. 즉, 데이터 소스를 확장하고 다음 섹션의 주제인 적절한 데이터 모델을 사용하도록 해야 합니다.
 */
