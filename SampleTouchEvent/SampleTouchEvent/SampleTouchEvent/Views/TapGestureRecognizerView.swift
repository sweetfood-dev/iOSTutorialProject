//
//  OneTapGestureRecognizerView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/08.
//

import UIKit

enum GestureRecognizerEvent: String, EventType {
    case oneTap = "recognized : One tap gesture"
    case longTouch = "recognized: long touch gestrue"
    case swipeLeft = "recognized: swipe left"
    case swiperight = "recognized: swipe right"
    case swipeup = "recognized: swipe up"
    case swipedown = "recognized: swipe down"
    var description: String { return "Gesture Type : \(self.rawValue)" }
}

class TapGestureRecognizerView: TouchHandlingView {
    lazy var gestureRecognizer = UITapGestureRecognizer(target: self,
                                                        action: #selector(oneTabGestureRecognizer(_:))) // Discrete 제스처
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Gesture Action
extension TapGestureRecognizerView {
    @objc func oneTabGestureRecognizer(_ sender: UITapGestureRecognizer) {
        eventType = GestureRecognizerEvent.oneTap
        print(sender.state.rawValue)
    }        
    
    @objc func edgeLeftGestureRecognizer(_ sender: UIScreenEdgePanGestureRecognizer) {
        print("[screenEdge left] state : \(sender.state.rawValue)")
    }
}

/*
extension UITapGestureRecognizer {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        print("recognizer began! \(state.rawValue)")
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        print("recognizer ended! \(state.rawValue)")
        super.touchesEnded(touches, with: event)
    }
}
*/
