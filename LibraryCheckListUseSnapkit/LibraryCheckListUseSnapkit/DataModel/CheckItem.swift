//
//  CheckItem.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/01.
//

import Foundation
import UIKit

enum ThumNailSymbol {
    case imageIcon(named: String)
    case letterSquare(letter: Character?)
    
    var image: UIImage {
        let imageName: String
        switch self {
        case .imageIcon(let name):
            imageName = name
        case .letterSquare(let letter):
            guard let letter = letter,
                  let image = UIImage(systemName: "\(letter).square")
            else {
                imageName = "square"
                return UIImage(systemName: imageName)!
            }
            return image
        }
        
        return UIImage(named: imageName)!
    }
}

struct CheckItem {
    var thumbNail: ThumNailSymbol
    var title: String
    var itemCount: String
    
    static var items: [CheckItem] {
        makeMokData()
    }
    
    static private func makeMokData() -> [CheckItem] {
        return [
            CheckItem(thumbNail: .imageIcon(named: "IconImage"), title: "공부", itemCount: "5"),
            CheckItem(thumbNail: .letterSquare(letter: "2"), title: "취미", itemCount: "5"),
            CheckItem(thumbNail: .letterSquare(letter: "3"), title: "집안일", itemCount: "5")
        ]
    }
}
