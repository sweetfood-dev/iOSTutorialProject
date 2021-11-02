//
//  CheckItem.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/01.
//

import Foundation
import UIKit

struct CheckItem: Hashable {
    var thumbNail: UIImage?
    var title: String
    var itemCount: String        
}


extension CheckItem: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case itemCount
    }
}
