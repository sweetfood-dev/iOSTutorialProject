//
//  SwipeGestureRecognizerView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/24.
//

import UIKit

class SwipeGestureRecognizerView: TouchHandlingView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    private func configuration() {
        setGesture(action: #selector(swipeLeftGestureRecognizer(_:)),
                   direction: .left)
        setGesture(action: #selector(swipeRightGestureRecognizer(_:)),
                   direction: .right)
        setGesture(action: #selector(swipeTopGestureRecognizer(_:)),
                   direction: .up)
        setGesture(action: #selector(swipeDownGestureRecognizer(_:)),
                   direction: .down)
    }
    
    private func setGesture(action: Selector, direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self,
                                               action: action)
        swipeGesture.direction = direction
        addGestureRecognizer(swipeGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SwipeGestureRecognizerView {
    @objc func swipeLeftGestureRecognizer(_ sender: UITapGestureRecognizer) {
        eventType = GestureRecognizerEvent.swipeLeft
    }
    @objc func swipeRightGestureRecognizer(_ sender: UITapGestureRecognizer) {
        eventType = GestureRecognizerEvent.swiperight
    }
    @objc func swipeTopGestureRecognizer(_ sender: UITapGestureRecognizer) {
        eventType = GestureRecognizerEvent.swipeup
    }
    @objc func swipeDownGestureRecognizer(_ sender: UITapGestureRecognizer) {
        eventType = GestureRecognizerEvent.swipedown
    }
}
