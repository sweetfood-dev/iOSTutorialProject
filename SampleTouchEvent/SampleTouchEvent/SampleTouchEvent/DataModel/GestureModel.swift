//
//  GestureModel.swift
//  SampleTouchEvent
//
//  Created by todoc on 2022/01/24.
//

import Foundation

enum GestureList: String, CaseIterable {
    case TapGesture = "Tap Gesture",
         SwipeGesture = "Swipe Gesture",
         PanGesture = "Pan Gesture",
         EdgePanGesture = "Edge Pan Gesture",
         LongGesture = "Long Gesture",
         RotationGesture = "Rotation Gesture",
         PinchGesture = "Pinch Gesture"
}
