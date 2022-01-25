//
//  EdgePanGestureRecognizerView.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/25.
//
import UIKit

class EdgePanGestureRecognizerView: UIView {
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
        backgroundColor = .white
        configuration()
    }
    private func configuration() {
        layoutConfiguration()
        gestureConfiguration()
    }
    private func layoutConfiguration() {
        addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    private func gestureConfiguration() {
        setGesture(action: #selector(handleEdgePanGesture(_:)),
                   edges: .right)
        setGesture(action: #selector(handleEdgePanGesture(_:)),
                   edges: .left)
        setGesture(action: #selector(handleEdgePanGesture(_:)),
                   edges: .top)
        setGesture(action: #selector(handleEdgePanGesture(_:)),
                   edges: .bottom)
    }
    private func setGesture(action: Selector, edges: UIRectEdge) {
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self,
                                               action: action)
        edgePanGesture.edges = edges
        addGestureRecognizer(edgePanGesture)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EdgePanGestureRecognizerView {
    @objc func handleEdgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        let distance = sender.translation(in: sender.view!)
        let edges = sender.edges.rawValue == 2 ? "Left" : "Right"
        stateText = "\(edges) distance x:\(Int(distance.x)) y:\(Int(distance.y))"
    }
}
