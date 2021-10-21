//
//  ListDetailViewController.swift
//  TableViewTutorial
//
//  Created by todoc on 2021/10/20.
//

import UIKit

protocol ListDetailViewControllerDelegate: AnyObject {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishAdding checklist: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController {
    
    lazy var doneBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        button.isEnabled = false
        
        return button
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        return button
    }()
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    var iconName = "Folder"
    
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setupUILayout()
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
            iconName = checklist.iconName
        }
        
        iconImage.image = UIImage(named: iconName)
        textField.addTarget(self, action: #selector(done), for: .editingDidEndOnExit)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
}
// MARK: - IconPickerViewControllerDelegate
extension ListDetailViewController: IconPickerViewControllerDelegate {
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
        self.iconName = iconName
        iconImage.image = UIImage(named: iconName)
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - UI Setup
extension ListDetailViewController {
    func setupUILayout() {
    }
}
// MARK: - UINavigation Controller
extension ListDetailViewController {
    func setNavigation() {
        navigationItem.rightBarButtonItem = doneBarButton
        navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickIcon" {
            let destination = segue.destination as! IconPickerViewController
            destination.delegate = self
        }
    }
}

// MARK: - Actions
extension ListDetailViewController {
    @objc func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @objc func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            checklist.iconName = iconName
            delegate?.listDetailViewController(self,
                                               didFinishEditing: checklist)
        }else {
            let checklist = Checklist(name: textField.text!, iconName: iconName)
            delegate?.listDetailViewController(self,
                                               didFinishAdding: checklist)
        }
    }
}

// MARK: - UITextFieldDelegate
extension ListDetailViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
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

// MARK: - TableViewDelegate
extension ListDetailViewController {
    
    override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
    
}
