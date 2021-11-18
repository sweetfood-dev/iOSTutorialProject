//
//  Navigationable.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/18.
//
import UIKit
import SnapKit

protocol Navigationable {
    // 정중앙에 표시될 label
    var label: UILabel { get }
    // navigation controller에 push 하기 위한 버튼
    var moveButton: UIButton { get }
    // label과 moveButton의 오토레이아웃 적용
    func setAutoLayout()
}

// UIViewController 타입일 때만 확장
extension Navigationable where Self: UIViewController{
    func setAutoLayout() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        view.addSubview(moveButton)
        moveButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
    }
}
