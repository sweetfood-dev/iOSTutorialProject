//
//  ChecklistItem.swift
//  TableViewTutorial
//
//  Created by 권지수 on 2021/10/18.
//

import Foundation
import UserNotifications

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
    
    deinit {
        // 삭제 될 때 해달 노티피케이션도 삭제
        removeNotification()
    }
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemId)"])
    }
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            
            // text를 노티피케이션 메세지로 사용
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = text
            content.sound = .default
            
            // dueDate에서 년,월,일,시,분을 추출
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute],
                                                     from: dueDate)
            
            // 지정된 날짜에 알림을 표시하는 트리거
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: false)
            
            // request 객체를 생성. 식별자는 고유번호인 itemID
            // itemID는 추후 노티피케이션을 취소하거나 수정할 떄 사용하여 해당 노티피케이션을 찾을 수 있음
            let request = UNNotificationRequest(
                identifier: String(itemId),
                content: content,
                trigger: trigger)
            
            // 새로운 노티피케이션을 추가
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("Scheduled: \(request) for itemID: \(itemId)")
        }
    }
}
