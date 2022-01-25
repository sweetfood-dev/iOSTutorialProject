//
//  CheckDiscreteGuestrureRecognizer.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/17.
//

import UIKit


// 현재 단계를 나타내는 열거형
enum CheckmarkPhase {
    case notStarted // 시작하지 않음
    case initialPoint // 초기 터치 위치
    case downStroke // 터치가 아래로 움직임
    case upStroke // 터치가 위로 움직임
}

class CheckmarkGestureRecognizer: UIGestureRecognizer {
    var strokePhase: CheckmarkPhase = .notStarted // 초기에는 시작되지 않음
    var initialTouchPoint: CGPoint = .zero // 초기 터치의 위치는 zero
    var trackedTouch: UITouch? = nil // 첫 번째 손가락(터치)를 저장, ( 이후 추적 )
}

extension CheckmarkGestureRecognizer {
    // 초기 조건을 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if touches.count != 1 { // 초기 이벤트의 터치 횟수가 2개 이상이면 바로 실패 처리
            state = .failed
        }
        if trackedTouch == nil { // trackedTouch가 nil이면 저장
            trackedTouch = touches.first
            strokePhase = .initialPoint // 초기 단계
            // UITouch 객체는 재사용되고, 재사용되어지면 프로퍼티 값이 변경되기 때문에 현재 위치를 저장
            initialTouchPoint = (trackedTouch?.location(in: self.view))!
        } else { // nil이 아니라면 첫 터치가 발생하고 유지되고 있다는 뜻, 추가된 새로운 터치들은 모두 무시
            for touch in touches {
                if touch != trackedTouch {
                    ignore(touch, for: event)
                }
            }
        }
    }
    
    // 터치 정보가 변경 되면 moved 메소드를 호출함
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let newTouch = touches.first
        // newTouch는 trakcedTouch와 같아야함
        // trackedToouch가 설정된 이후 다른 터치들은 무시되었기 때문
        guard newTouch == trackedTouch else {
            state = .failed
            return
        }
        let newPoint = (newTouch?.location(in: self.view))!
        let previousPoint = (newTouch?.previousLocation(in: self.view))!
        if strokePhase == .initialPoint {
            if newPoint.x >= initialTouchPoint.x && newPoint.y >= initialTouchPoint.y {
                strokePhase = .downStroke
            } else {
                state = .failed
            }
        } else if strokePhase == .downStroke {
            if newPoint.x >= previousPoint.x {
                if newPoint.y < previousPoint.y {
                    strokePhase = .upStroke
                }
            } else {
                state = .failed
            }
        } else if strokePhase == .upStroke {
            if newPoint.x < previousPoint.x || newPoint.y > previousPoint.y  {
                state = .failed
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        let newTouch = touches.first
        let newPoint = (newTouch?.location(in: self.view))!
        
        guard newTouch == trackedTouch else {
            state = .failed
            return
        }
        
        if state == .possible &&
            strokePhase == .upStroke &&
            newPoint.y < initialTouchPoint.y {
            state = .recognized
        } else {
                state = .failed
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        resetAction()
        state = .cancelled
    }
    override func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent) {
        super.pressesCancelled(presses, with: event)
        resetAction()
        state = .cancelled
    }
    override func reset() {
        super.reset()
        resetAction()
    }
    
    private func resetAction() {
        initialTouchPoint = .zero
        strokePhase = .notStarted
        trackedTouch = nil
    }
}
