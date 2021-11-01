//
//  AuteurTableViewCell.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/28.
//

import UIKit
import SnapKit

class AuteurTableViewCell: UITableViewCell, UITableViewRegisterable {
    lazy var auteurImageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray4
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray4
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray4
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        sv.axis = .vertical
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.init(named: "AuteursBackground")
        selectionStyle = .none
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setAutoLayout() {
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(auteurImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(bioLabel)
        stackView.addArrangedSubview(sourceLabel)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        auteurImageView.snp.makeConstraints { make in
            make.width.equalTo(auteurImageView.snp.height)
        }
        
        
    }
    
    func configure(
        name: String,
        bio: String,
        source: String,
        imageName: String
    ) -> Self {
        nameLabel.text = name
        bioLabel.text = bio
        sourceLabel.text = source
        auteurImageView.image = UIImage(named: imageName)
        
        return self
    }
}
