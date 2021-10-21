//
//  Checklist.swift
//  TableViewTutorial
//
//  Created by todoc on 2021/10/20.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    var iconName = "No icon"
    init(name: String, iconName: String = "No Icon") {
        super.init()
        self.name = name
        self.iconName = iconName
    }
    
    func countUncheckItems() -> Int {
        return items.filter {
            !$0.checked }.count
    }
}


/*
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
 */
