//
//  TouchHandlingView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2021/12/29.
//

import UIKit
import SnapKit

enum TouchEvent: String, EventType {
    case Began = "View began", Moved = "View moved", Ended = "View ended", Cancelled = "View cancelled", None = "None"
    
    var description: String { return "Touch Event current step [\(self.rawValue)]" }
}



class TouchHandlingView: UIView {        
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.text = "Display Handling Phase\n"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    var printTouchEventType = true
    var eventType: EventType = TouchEvent.None {
        willSet {
            if eventType as? TouchEvent == TouchEvent.Ended
                || eventType as? TouchEvent == TouchEvent.Cancelled {
                stepLabel.text = ""
            }
        }
        didSet {
            stepLabel.text?.append("\(eventType.description)\n")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurations()
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configurations()
    }
    
    private func configurations() {
        addSubview(stepLabel)
        stepLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}


// MARK: - Handlig Touch method
extension TouchHandlingView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if printTouchEventType {
            eventType = TouchEvent.Began
            print("view began touches ")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if printTouchEventType {
            eventType = TouchEvent.Moved
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if printTouchEventType {
            eventType = TouchEvent.Ended
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if printTouchEventType {
            eventType = TouchEvent.Cancelled
        }
    }
}
