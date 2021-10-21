//
//  DataModel.swift
//  TableViewTutorial
//
//  Created by todoc on 2021/10/21.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(
                forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(
                newValue,
                forKey: "ChecklistIndex")
        }
    }
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    func registerDefaults() {
        let dictionary = ["ChecklistIndex": -1,
                          "FirstTime": true
        ] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checkList = Checklist(name: "List")
            lists.append(checkList)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
        }
    }
    
    func sortChecklists() {
        lists.sort { list1, list2 in
            return list1.name.localizedStandardCompare(list2.name) == .orderedAscending
        }
    }
}

// MARK: - Documents
extension DataModel {
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask)
        
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(
                to: dataFilePath(),
                options: .atomic)
        }catch {
            print("encoder error : \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {
        let filePath = dataFilePath()
        if let data = try? Data(contentsOf: filePath) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode(
                    [Checklist].self,
                    from: data)
                sortChecklists()
            }catch {
                print("decoder error : \(error.localizedDescription)")
            }
        }
        
    }
}

// MARK: - Class Method
extension DataModel {
    /// 고유한 item id를 생성하는 클래스 메소드
    /// 생성한 고유한 itemId를 UserDefaults에 저장
    /// - Returns: itemId로 사용할 값
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        return itemID
    }
}
