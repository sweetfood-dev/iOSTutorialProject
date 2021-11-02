//
//  CheckListCell.swift
//  LibraryCheckListUseSnapkit
//
//  Created by todoc on 2021/11/01.
//

import UIKit

class CheckListCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.text = "타이틀"
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.text = "항목 수"
        return label
    }()
    
    lazy var imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "IconImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setAutoLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        contentView.addSubview(imageIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
    }
    
    private func setAutoLayout() {
        imageIcon.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(imageIcon.snp.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageIcon)
            make.leading.equalTo(imageIcon.snp.trailing).offset(20)
            make.height.equalTo(imageIcon).dividedBy(2)
        }
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(imageIcon)
        }
    }
}

// MARK: - Set Cell Contents
extension CheckListCell {
    func configure(_ item: CheckItem) -> Self {
        imageIcon.image = item.thumbNail.image
        titleLabel.text = item.title
        subLabel.text = item.itemCount
        
        return self
    }
}
// MARK: - UITableViewRegisterable
extension CheckListCell: UITableViewRegisterable {
}


// MARK: - Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CheckListCellPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = CheckListCell(style: .default, reuseIdentifier: CheckListCell.reuseIdentifier)
            return cell
        }.previewLayout(.sizeThatFits)
    }
}
#endif

