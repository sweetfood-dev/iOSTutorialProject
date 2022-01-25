//
//  PangestureView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/20.
//

import UIKit

class PangestureView: UIView {
    var initialCenter = CGPoint()
    lazy var directionLabel: UILabel = {
        let label = UILabel()
        label.text = "pan gesture recognizer"
        return label
    }()
    
    lazy var yellowView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.backgroundColor = .yellow
        view.addSubview(directionLabel)
        directionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
    
    private var directionText = "" {
        didSet {
            directionLabel.text = directionText
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(yellowView)
        let pangesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(panhandler(_:)))
        yellowView.addGestureRecognizer(pangesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PangestureView {
    @objc func panhandler(_ sender: UIPanGestureRecognizer) {
        // 연결된 view가 없다면 종료
        guard let recognizerView = sender.view else { return }
        
        let point = sender.translation(in: recognizerView)
        recognizerView.center = CGPoint(x: recognizerView.center.x + point.x,
                                        y: recognizerView.center.y + point.y)
        sender.setTranslation(.zero, in: recognizerView)
        let velocity = sender.velocity(in: recognizerView)
        directionText = computeDirection(velocity: velocity)
        /*
        // 시작 단계이면 초기 위치를 저장
        if sender.state == .began {
            initialCenter = recognizerView.center
        }
        
        // 제스처 인식기가 초기화 되면 원래 상태로 되돌림
        if sender.state == .cancelled {
            recognizerView.center = initialCenter
        }else { // change / ended 일 때
            let translation = sender.translation(in: recognizerView)
            recognizerView.center = CGPoint(x: initialCenter.x + translation.x,
                                            y: initialCenter.y + translation.y)
        }*/
    }
    
    private func computeDirection(velocity: CGPoint) -> String {
        // 수평 pan 제스처
        if abs(velocity.x) > abs(velocity.y) {
            return velocity.x < 0 ? "left" : "right"
        } else { // 수직 pan 제스처
            return velocity.y < 0 ? "up" : "down"
        }
    }
}
