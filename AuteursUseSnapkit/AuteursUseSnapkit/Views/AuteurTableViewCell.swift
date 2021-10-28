//
//  AuteurTableViewCell.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/28.
//

import UIKit

class AuteurTableViewCell: UITableViewCell {
    lazy var auteurImageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init sytle: reuseidentifier")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init coder")
    }
}
