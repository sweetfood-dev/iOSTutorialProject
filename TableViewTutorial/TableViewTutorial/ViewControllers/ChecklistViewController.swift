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
    var checklist: Checklist!
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(moveNextViewController(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationViewController Title 설정
        setNavigationItem()
        
        // load items
        loadChecklistItems()
        
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

// MARK: - Documents
extension ChecklistViewController {
    /// 샌드박스 Documents 폴더의 전체 경로를 반환
    /// - Returns: Documents 폴더의 전체 경로
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask)
        return paths[0]
    }
    /// documentsDirectory()를 사용하여 체크리스트의 항목을 저장할 파일의 전체 경로를 구성, 파일명은 Checklists.plist
    /// - Returns: 저장할 파일의 전체 경로
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    /// items를 Documents에 저장하는 메소드
    func saveChecklistItems() {
        // 인코딩 가능한 PropertyListEncoder를 생성
        let encoder = PropertyListEncoder()
        // 에러 핸들링 시작
        do {
            // items를 인코딩하여 data에 할당, 인코딩할 수 없는 경우 에러를 던지기 때문에 try 키워드 사용
            let data = try encoder.encode(items)
            // 인코딩 된 data를 dataFilePath() 경로에 저장, 이 또한 저장할 수 없는 경우 에러를 던지기 때문에 try 키워드 사용
            try data.write(to: dataFilePath(),
                           options: .atomic)
        } catch { // do 블럭안의 try 코드행에서 에러가 발생한 경우 catch문이 실행되어 짐
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklistItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode(
                    [ChecklistItem].self,
                    from: data)
            }catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
}
// MARK: - Segue
extension ChecklistViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
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
        if let index = items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
        
        saveChecklistItems()
    }
    /// 아이템이 추가되었을 때 호출
    /// - Parameters:
    ///   - controller: 호출한 VC
    ///   - item: 추가된 ChecklistItem
    func ItemDetailViewController(_ controller: ItemDetailViewController,
                               didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
        
        saveChecklistItems()
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
        
        saveChecklistItems()
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
        
        saveChecklistItems()
    }
}

/*
 Issue1 : 선택을 해제하고 행을 올리다보면 다른행에서 해당 셀을 재사용하기 때문에 체크가 해제되거나 다시 선택되는 경우가 있음
 -> 체크 표시를 표시할지 여부를 기억하기 위해 셀의 액세서리를 사용하는 대신 각 행의 확인 상태를 추적하는 방법이 필요합니다. 즉, 데이터 소스를 확장하고 다음 섹션의 주제인 적절한 데이터 모델을 사용하도록 해야 합니다.
 */
