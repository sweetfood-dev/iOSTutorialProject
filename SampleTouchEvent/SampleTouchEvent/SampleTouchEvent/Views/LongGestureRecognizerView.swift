//
//  LongGestureRecognizerView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/25.
//
import UIKit

class LongGestureRecognizerView: UIView {
    // 첫번째 Responder가 될 수 있는지 여부를 나타내는 Bool 값, get 프로퍼티이기 때문에 오버라이드하여 true 설정
    override var canBecomeFirstResponder: Bool { return true }
    private var menuController: UIMenuController?
    private lazy var stateLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    private var stateText = "" {
        didSet {
            stateLabel.text = stateText
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        layoutConfiguration()
        gestureConfiguration()
    }
    
    private func layoutConfiguration() {
        backgroundColor = .white
        addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func gestureConfiguration() {
        let longGesture = UILongPressGestureRecognizer(target: self,
                                                       action: #selector(showMenuBox(_:)))
        addGestureRecognizer(longGesture)
    }
    
    @objc func showMenuBox(_ sender: UILongPressGestureRecognizer) {
        guard let recognizerView = sender.view else { return }
        if sender.state == .ended {
            stateText = "Display MenuController"
            let location = sender.location(in: recognizerView)
            showMenuController(recognizerView, location: location)
        }else {
            stateText = sender.state == .changed ? "Changed" : "Began"
        }
    }
    private func showMenuController(_ recognizerView: UIView, location: CGPoint) {
        becomeFirstResponder()
        let menuItemTitle = "Reset"
        let closeMenuItem = UIMenuItem(title: menuItemTitle,
                                       action: #selector(closeMenuView(_:)))
        if menuController == nil {
            menuController = UIMenuController.shared
        }
        
        menuController?.menuItems = [closeMenuItem]
        let menuLocation = CGRect(x: location.x,
                                  y: location.y,
                                  width: 0,
                                  height: 0)
        menuController?.showMenu(from: recognizerView,
                                 rect: menuLocation)
    }
    @objc func closeMenuView(_ sender: Any) {
        menuController!.hideMenu(from: self)
    }
}

