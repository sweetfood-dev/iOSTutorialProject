//
//  TouchCaptureGesture.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/18.
//

import UIKit

struct StrokeSample {
    let location: CGPoint
    
    init(location: CGPoint) {
        self.location = location
    }
}
class TouchCaptureGesture: UIGestureRecognizer, NSCoding {
    var trackedTouch: UITouch? = nil
    var samples = [StrokeSample]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(target: nil, action: nil)
        self.samples = [StrokeSample]()
    }
    
    func encode(with coder: NSCoder) {
    }
}

extension TouchCaptureGesture {
    func addSample(for touch: UITouch) {
        let newSample = StrokeSample(location: touch.location(in: self.view))
        self.samples.append(newSample)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if touches.count != 1 {
            state = .failed
        }
        
        if self.trackedTouch == nil {
            if let firstTouch = touches.first {
                trackedTouch = firstTouch
                addSample(for: firstTouch)
                state = .began
            }
        }else {
            for touch in touches {
                if touch != trackedTouch {
                    ignore(touch, for: event)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        addSample(for: touches.first!)
        state = .changed
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        addSample(for: touches.first!)
        state = .ended
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.samples.removeAll()
       state = .cancelled
    }
     
    override func reset() {
       self.samples.removeAll()
       self.trackedTouch = nil
    }
}
