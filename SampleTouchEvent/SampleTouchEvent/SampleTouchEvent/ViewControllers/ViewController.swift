//
//  ViewController.swift
//  SampleTouchEvent
//
//  Created by todoc on 2021/12/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var handlingView = TouchHandlingView(frame: .zero)
    lazy var oneTapRecognizerView = TapGestureRecognizerView(frame: .zero)
    lazy var swipeRecognizerView = SwipeGestureRecognizerView(frame: .zero)
    lazy var panRecognizerView = PangestureView(frame: .zero)
    lazy var edgePanRecognizerView = EdgePanGestureRecognizerView(frame: .zero)
    lazy var longTouchRecognizerView = LongGestureRecognizerView(frame: .zero)
    lazy var rotationRecognizerView = RotationRecognizerView(frame: .zero)
    lazy var pinchRecognizerView = PinchRecognizerView(frame: .zero)
    
    var gestureType: GestureList?
    lazy var errorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "gestureType is nil"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
    private lazy var gestureContentView: UIView = {
        guard let gestureType = gestureType else {
            return errorView
        }

        switch gestureType {
        case .TapGesture:
            return oneTapRecognizerView
        case .SwipeGesture:
            return  swipeRecognizerView
        case .PanGesture:
            return panRecognizerView
        case .EdgePanGesture:
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            return edgePanRecognizerView
        case .LongGesture:
            return longTouchRecognizerView
        case .RotationGesture:
            return rotationRecognizerView
        case .PinchGesture:
            return pinchRecognizerView
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        print("loadView")
        self.view = gestureContentView
    }
    
    private func configuration() {
    }
}
