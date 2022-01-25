//
//  RotationRecognizerView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/25.
//
import UIKit

class RotationRecognizerView: UIView {
    // 회전할 뷰를 생성
    private lazy var rotationView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: 200, height: 200))
        view.backgroundColor = .systemRed
        let label = UILabel()
        label.text = "content"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
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
        addSubview(rotationView)
        rotationView.backgroundColor = .systemRed
        rotationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    private func gestureConfiguration() {
        let rotationGesture = UIRotationGestureRecognizer(target: self,
                                                          action: #selector(rotationHandle(_:)))
        
        addGestureRecognizer(rotationGesture)
    }
    
    @objc func rotationHandle(_ sender: UIRotationGestureRecognizer) {
        rotationView.transform = rotationView.transform.rotated(by: sender.rotation)
        // 변경된 transfrom 기준으로 각도를 0으로 설정
        sender.rotation = 0
    }
}
