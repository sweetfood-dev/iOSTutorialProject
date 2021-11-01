//
//  AuteurDetailTableViewCell.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/29.
//

import UIKit
import SnapKit

class AuteurDetailTableViewCell: UITableViewCell, UITableViewRegisterable {
    static let moreInfoText = "Tap For Details >"
    lazy var auteurImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    lazy var titlaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textColor = .systemGray2
        label.textAlignment = .center
        return label
    }()
    
    lazy var moreInfoTextView: UILabel = {
        let textView = UILabel()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textView.textColor = .red
        textView.text = Self.moreInfoText
        textView.textAlignment = .center
        textView.numberOfLines = 0
//        textView.isEditable = true
//        textView.isSelectable = true
//        textView.autocapitalizationType = .sentences
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.init(named: "AuteursBackground")
        selectionStyle = .none
        addViews()
        setAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't call this message")
    }
    func addViews() {
        contentView.addSubview(auteurImageView)
        contentView.addSubview(titlaLabel)
        contentView.addSubview(moreInfoTextView)
    }
    func setAutolayout() {
        auteurImageView.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview().inset(8)
        }
        
        titlaLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(auteurImageView.snp.width)
            make.top.equalTo(auteurImageView.snp.bottom).offset(8)
        }
        
        moreInfoTextView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(8)
            make.top.equalTo(titlaLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func configure(title: String, info: String, image: String, isExpended: Bool) {
        titlaLabel.text = title
        auteurImageView.image = UIImage(named: image)
        
        moreInfoTextView.text = isExpended ? info : Self.moreInfoText
        moreInfoTextView.textAlignment = isExpended ? .left : .center
        moreInfoTextView.textColor = isExpended ? .systemGray3 : .systemRed
        selectionStyle = .none
    }
}
