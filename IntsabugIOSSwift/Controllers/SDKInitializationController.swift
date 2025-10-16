//
//  SDKInitializationController.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 29/09/2025.
//

import Foundation
import LuciqSDK

class SDKInitializationController {
    func handleSubmit(inputText: String, selectedEvents: Set<String>) -> Bool {
        // Validate token
        let token = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !token.isEmpty else {
            return false
        }
        
        let hasShake = selectedEvents.contains("Shake")
        let hasScreenshot = selectedEvents.contains("Screenshot")
        let hasSwipe = selectedEvents.contains("Two Finger Swipe")
        let hasRightEdgePan = selectedEvents.contains("Right Edge Pan")
        let hasFloatingButton = selectedEvents.contains("Floating Button")
        
        switch (hasShake, hasScreenshot, hasSwipe, hasRightEdgePan, hasFloatingButton) {
                    
                case (true, false, false, false, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake])
                case (false, true, false, false, false):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot])
                case (false, false, true, false, false):
                    Luciq.start(withToken: token, invocationEvents: [.twoFingersSwipeLeft])
                case (false, false, false, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.rightEdgePan])
                case (false, false, false, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.floatingButton])
                case (true, true, false, false, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot])
                case (true, false, true, false, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .twoFingersSwipeLeft])
                case (true, false, false, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .rightEdgePan])
                case (true, false, false, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .floatingButton])
                case (false, true, true, false, false):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot, .twoFingersSwipeLeft])
                case (false, true, false, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot, .rightEdgePan])
                case (false, true, false, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot, .floatingButton])
                case (false, false, true, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.twoFingersSwipeLeft, .rightEdgePan])
                case (false, false, true, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.twoFingersSwipeLeft, .floatingButton])
                case (false, false, false, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.rightEdgePan, .floatingButton])
                case (true, true, true, false, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot, .twoFingersSwipeLeft])
                case (true, true, false, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot, .rightEdgePan])
                case (true, true, false, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot, .floatingButton])
                case (true, false, true, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .twoFingersSwipeLeft, .rightEdgePan])
                case (true, false, true, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .twoFingersSwipeLeft, .floatingButton])
                case (true, false, false, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .rightEdgePan, .floatingButton])
                case (false, true, true, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot, .twoFingersSwipeLeft, .rightEdgePan])
                case (false, true, true, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot, .twoFingersSwipeLeft, .floatingButton])
                case (false, true, false, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot, .rightEdgePan, .floatingButton])
                case (false, false, true, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.twoFingersSwipeLeft, .rightEdgePan, .floatingButton])
                case (true, true, true, true, false):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot, .twoFingersSwipeLeft, .rightEdgePan])
                case (true, true, true, false, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot, .twoFingersSwipeLeft, .floatingButton])
                case (true, true, false, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot, .rightEdgePan, .floatingButton])
                case (true, false, true, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .twoFingersSwipeLeft, .rightEdgePan, .floatingButton])
                case (false, true, true, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.screenshot, .twoFingersSwipeLeft, .rightEdgePan, .floatingButton])
                case (true, true, true, true, true):
                    Luciq.start(withToken: token, invocationEvents: [.shake, .screenshot, .twoFingersSwipeLeft, .rightEdgePan, .floatingButton])
                    
                default:
                    Luciq.start(withToken: token, invocationEvents: .none)
                }
        
        return true
    }
    
}
