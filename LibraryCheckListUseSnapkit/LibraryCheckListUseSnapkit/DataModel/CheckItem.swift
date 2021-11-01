//
//  CheckItem.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/01.
//

import Foundation

struct CheckItem {
    var thumbNail: String
    var title: String
    var itemCount: String
    
    static var items: [CheckItem] {
        makeMokData()
    }
    
    static private func makeMokData() -> [CheckItem] {
        return [
            CheckItem(thumbNail: "IconImage", title: "공부", itemCount: "5"),
            CheckItem(thumbNail: "IconImage", title: "취미", itemCount: "5"),
            CheckItem(thumbNail: "IconImage", title: "집안일", itemCount: "5")
        ]
    }
}
