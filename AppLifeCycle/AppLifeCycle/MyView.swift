//
//  MyView.swift
//  AppLifeCycle
//
//  Created by todoc on 2022/01/27.
//

import UIKit

class MyView: UIView {
    // MARK: - Properties
    
    // Just programatically made subview
    lazy var mySubView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false // Turn off autolayout
        return view
    }()    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
        
        setupUI()
        styleView()
    }
    
    required init?(coder: NSCoder) {
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func didAddSubview(_ subview: UIView) {
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func didMoveToSuperview() {
        print("🟤 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
}

// MARK: - UI Setup
extension MyView {
    private func setupUI() {
        print("Adding 'mySubView'")
        addSubview(mySubView)
        mySubView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mySubView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mySubView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mySubView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func styleView() {
        backgroundColor = .blue
    }
}
