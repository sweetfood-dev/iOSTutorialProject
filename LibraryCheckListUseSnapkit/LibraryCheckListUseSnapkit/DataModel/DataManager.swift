//
//  DataManager.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/02.
//

import UIKit

class DataManager {
    static var items: [CheckItem] {
        loadData()
    }
    
    static private let ChecklistsJSONURL = URL(fileURLWithPath: "Checklists",
                                               relativeTo: FileManager.documentDirectoryURL)
        .appendingPathExtension("json")
    
    
    static private func makeMokData() -> [CheckItem] {
        print("mok Data")
        return [
            CheckItem(title: "공부", itemCount: "5"),
            CheckItem(title: "취미", itemCount: "5"),
            CheckItem(title: "집안일", itemCount: "5")
        ]
    }
    
    private static func loadData() -> [CheckItem] {
        let decoder = JSONDecoder()
        
        guard let checklistData = try? Data(contentsOf: ChecklistsJSONURL) else {
            return makeMokData()
        }
        do{
            let checklists = try decoder.decode([CheckItem].self, from: checklistData)
            return checklists.map { checklist in
                CheckItem(thumbNail: loadImage(forCheckItem: checklist),
                          title: checklist.title,
                          itemCount: checklist.itemCount)
            }
        }catch {
            print(error.localizedDescription)
            return makeMokData()
        }
    }
    
    static func saveAllData() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let checklistData = try encoder.encode(items)
            try checklistData.write(to: ChecklistsJSONURL, options: .atomic)
        }catch {
            print(error)
        }
    }
    
    static func savedImage(_ image: UIImage, forCheckItem checkItem: CheckItem) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathExtension(checkItem.title)
        if let jpgData = image.jpegData(compressionQuality: 0.7) {
            try? jpgData.write(to: imageURL, options: .atomic)
        }
    }
    
    static func loadImage(forCheckItem checkItem: CheckItem) -> UIImage? {
        let imageURL = FileManager.documentDirectoryURL.appendingPathExtension(checkItem.title)
        return UIImage(contentsOfFile: imageURL.path)
    }
    
}


extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
