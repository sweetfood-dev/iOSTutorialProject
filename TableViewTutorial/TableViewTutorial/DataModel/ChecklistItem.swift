//
//  ChecklistItem.swift
//  TableViewTutorial
//
//  Created by 권지수 on 2021/10/18.
//

import Foundation

/// Checklist의 데이터 모델
/// text : 할 일
/// checked : 선택 유무 
class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    /// 언제 노티피케이션을 발생 시킬 건지
    var dueDate = Date()
    /// 노티피케이션을 발생 여부
    var shouldRemind = false
    /// 노티피케이션의 identifier로 사용할 Int 타입 
    var itemId = -1
    
    override init() {
        super.init()
        itemId = DataModel.nextChecklistItemID()
    }
}
