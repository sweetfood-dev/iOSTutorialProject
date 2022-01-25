//
//  PinchRecognizerView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/25.
//

import UIKit

class PinchRecognizerView: UIView {
    let defaultScale: CGFloat = 1
    lazy var pinchTargetView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "scale"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.backgroundColor = .systemBlue
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
        addSubview(pinchTargetView)
        pinchTargetView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    private func gestureConfiguration() {
        let pinchRecognizer = UIPinchGestureRecognizer(target: self,
                                                       action: #selector(pinchHandler(_:)))
        addGestureRecognizer(pinchRecognizer)
    }
    
    @objc private func pinchHandler(_ sender: UIPinchGestureRecognizer) {
        pinchTargetView.transform = pinchTargetView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = defaultScale
    }
    
}
