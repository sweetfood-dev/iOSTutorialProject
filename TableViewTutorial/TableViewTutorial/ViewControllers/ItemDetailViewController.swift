//
//  AddItemViewController.swift
//  TableViewTutorial
//
//  Created by 권지수 on 2021/10/18.
//

import UIKit

protocol ItemDetailViewControllerDelegate: AnyObject {
    func ItemDetailViewControllerDidCancel(
        _ controller: ItemDetailViewController)
    func ItemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishAdding item: ChecklistItem
    )
    func ItemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController {
    weak var delegate: ItemDetailViewControllerDelegate?
    lazy var doneBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addItemDone(_:)))
        button.isEnabled = false
        return button
    }()
    
    lazy var leftButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton(_:)))
        return button
    }()
    
    var itemToEdit: ChecklistItem?
    
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        setNavigationItem()
        setTextField()
        shouldRemindSwitch.addTarget(self, action: #selector(shouldReminderToggled(_:)), for: .valueChanged)
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
            shouldRemindSwitch.isOn = item.shouldRemind
            datePicker.date = item.dueDate
        }
    }
    @IBAction func shouldRemindToggled2(_ switchControl: UISwitch) {
      textField.resignFirstResponder()

      if switchControl.isOn {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {_, _ in
          // do nothing
        }
      }
    }
}
// MARK: - TextField Method
extension ItemDetailViewController: UITextFieldDelegate {
    func setTextField() {
        textField.delegate = self
        // // .edigingDidEndOnExit : 키보드에서 return / done같은 엔터키를 눌렀을 때 발생하는 이벤트
        textField.addTarget(self, action: #selector(addItemDone(_:)), for: .editingDidEndOnExit)
        // 엔터키 설정 시 자동으로 키보드 내림
        textField.enablesReturnKeyAutomatically = true
        // 한번에 텍스트필드를 지우는 버튼 생성
        textField.clearButtonMode = .whileEditing
    }
    
    /// 텍스트 필드의 텍스트가 변경될 때 마다 호출 되는 델리게이트 메소드
    /// 새로운 텍스트를 알려주는게 아닌, 변경해야 하는 범위(range)와 교체해야하는 텍스트(string)만을 제공함
    /// - Parameters:
    ///   - textField: 변경된 텍스트 필드
    ///   - range: 변경해야할 범위
    ///   - string: 교체해야하는 텍스트
    /// - Returns: 불리언
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(
            in: stringRange,
            with: string)
        
        doneBarButton.isEnabled = !newText.isEmpty
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
}
// MARK: - Navigation Method
extension ItemDetailViewController {
    func setNavigationItem() {
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.leftBarButtonItem = leftButtonItem
        
        navigationItem.title = "Add Item"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func addItemDone(_ sender: UIBarButtonItem) {
        if let item = itemToEdit {
            item.text = textField.text!
            
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = datePicker.date
            item.scheduleNotification()
            delegate?.ItemDetailViewController(self, didFinishEditing: item)
        }else {
            let item = ChecklistItem()
            item.text = textField.text!
            
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = datePicker.date
            item.scheduleNotification()
            delegate?.ItemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    @objc func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.ItemDetailViewControllerDidCancel(self)
    }
}


// MARK: - Table View Delegate
extension ItemDetailViewController {
    /// 특정 행을 선택하려 할 때 호출되는 메소드
    /// - Parameters:
    ///   - tableView: 선택될 행의 TableView
    ///   - indexPath: 선택될 행의 IndexPath
    /// - Returns: 최종 선택할 행의 IndexPath
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
}

// TODO: 토글 이벤트 수신이 안됨
// MARK: - ACtions
extension ItemDetailViewController {
    @objc func shouldReminderToggled(_ switchControl: UISwitch) {
        textField.resignFirstResponder()
        print("toggle")
        if switchControl.isOn {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                if let error = error {
                    print("notification Error \(error.localizedDescription)")
                    return
                }
                if granted { print("get notification permission") }
            }
        }
    }
}
