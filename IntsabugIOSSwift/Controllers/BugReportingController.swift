//
//  BugReportingViewModel.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import Foundation
import LuciqSDK

class BugReportingController: ObservableObject{
    
    @Published var isEnabled = true
    @Published var emailOption = "Required"
    @Published var commentOption = "Optional"
    @Published var commentCharacterCount = ""
    @Published var attachmentOptions: Set<String> = ["📸"]
    @Published var autoScreenRecording = false
    @Published var autoScreenRecordingDuration = ""
    @Published var viewHierarchyOption = false
    @Published var proactiveBugReportingOption = false
    @Published var extendedBugReportingOption = false
    @Published var ebrFieldsOption = "Disabled"
    
    func handleStateChange(){
        if isEnabled {
                    BugReporting.enabled = true
                } else {
                    BugReporting.enabled = false
                }
    }
    
    func updateInvocationEvents(selectedEvents: Set<String>){
        
        let hasShake = selectedEvents.contains("Shake")
        let hasScreenshot = selectedEvents.contains("Screenshot")
        let hasSwipe = selectedEvents.contains("Two Finger Swipe")
        let hasRightEdgePan = selectedEvents.contains("Right Edge Pan")
        let hasFloatingButton = selectedEvents.contains("Floating Button")
        
        switch (hasShake, hasScreenshot, hasSwipe, hasRightEdgePan, hasFloatingButton) {
                    
                case (true, false, false, false, false):
                    BugReporting.invocationEvents = [.shake]
                case (false, true, false, false, false):
                    BugReporting.invocationEvents = [.screenshot]
                case (false, false, true, false, false):
                    BugReporting.invocationEvents = [.twoFingersSwipeLeft]
                case (false, false, false, true, false):
                    BugReporting.invocationEvents = [.rightEdgePan]
                case (false, false, false, false, true):
                    BugReporting.invocationEvents = [.floatingButton]
                case (true, true, false, false, false):
                    BugReporting.invocationEvents = [.shake, .screenshot]
                case (true, false, true, false, false):
                    BugReporting.invocationEvents = [.shake, .twoFingersSwipeLeft]
                case (true, false, false, true, false):
                    BugReporting.invocationEvents = [.shake, .rightEdgePan]
                case (true, false, false, false, true):
                    BugReporting.invocationEvents = [.shake, .floatingButton]
                case (false, true, true, false, false):
                    BugReporting.invocationEvents = [.screenshot, .twoFingersSwipeLeft]
                case (false, true, false, true, false):
                    BugReporting.invocationEvents = [.screenshot, .rightEdgePan]
                case (false, true, false, false, true):
                    BugReporting.invocationEvents = [.screenshot, .floatingButton]
                case (false, false, true, true, false):
                    BugReporting.invocationEvents = [.twoFingersSwipeLeft, .rightEdgePan]
                case (false, false, true, false, true):
                    BugReporting.invocationEvents = [.twoFingersSwipeLeft, .floatingButton]
                case (false, false, false, true, true):
                    BugReporting.invocationEvents = [.rightEdgePan, .floatingButton]
                case (true, true, true, false, false):
                    BugReporting.invocationEvents = [.shake, .screenshot, .twoFingersSwipeLeft]
                case (true, true, false, true, false):
                    BugReporting.invocationEvents = [.shake, .screenshot, .rightEdgePan]
                case (true, true, false, false, true):
                    BugReporting.invocationEvents = [.shake, .screenshot, .floatingButton]
                case (true, false, true, true, false):
                    BugReporting.invocationEvents = [.shake, .twoFingersSwipeLeft, .rightEdgePan]
                case (true, false, true, false, true):
                    BugReporting.invocationEvents = [.shake, .twoFingersSwipeLeft, .floatingButton]
                case (true, false, false, true, true):
                    BugReporting.invocationEvents = [.shake, .rightEdgePan, .floatingButton]
                case (false, true, true, true, false):
                    BugReporting.invocationEvents = [.screenshot, .twoFingersSwipeLeft, .rightEdgePan]
                case (false, true, true, false, true):
                    BugReporting.invocationEvents = [.screenshot, .twoFingersSwipeLeft, .floatingButton]
                case (false, true, false, true, true):
                    BugReporting.invocationEvents = [.screenshot, .rightEdgePan, .floatingButton]
                case (false, false, true, true, true):
                    BugReporting.invocationEvents = [.twoFingersSwipeLeft, .rightEdgePan, .floatingButton]
                case (true, true, true, true, false):
                    BugReporting.invocationEvents = [.shake, .screenshot, .twoFingersSwipeLeft, .rightEdgePan]
                case (true, true, true, false, true):
                    BugReporting.invocationEvents = [.shake, .screenshot, .twoFingersSwipeLeft, .floatingButton]
                case (true, true, false, true, true):
                    BugReporting.invocationEvents = [.shake, .screenshot, .rightEdgePan, .floatingButton]
                case (true, false, true, true, true):
                    BugReporting.invocationEvents = [.shake, .twoFingersSwipeLeft, .rightEdgePan, .floatingButton]
                case (false, true, true, true, true):
                    BugReporting.invocationEvents = [.screenshot, .twoFingersSwipeLeft, .rightEdgePan, .floatingButton]
                case (true, true, true, true, true):
                    BugReporting.invocationEvents = [.shake, .screenshot, .twoFingersSwipeLeft, .rightEdgePan, .floatingButton]
                    
                default:
                    BugReporting.invocationEvents = [.none]
                }
    }
    
    func showPrompt(promptType: String){
        
        switch (promptType) {
        case "Full":
            Luciq.show()
        case "Bug":
            BugReporting.show(with: .bug, options: [])
        case "Feedback":
            BugReporting.show(with: .feedback, options: [])
        case "Question":
            BugReporting.show(with: .question, options: [])
        default:
            print("Incorrect prompt type")
        }
    }
    
    func applySettings(
        emailOption: String, commentOption: String, minCharacter: String, attachmentsTypes: Set<String>, autoScreenRecording: Bool,
        autoScreenRecordingDuration: String, viewHierarchy1: Bool, proactiveBugReportingState: Bool, extendedBugReportingState: Bool, ebrFields: String
    ){
        
        if(emailOption != "Required" && emailOption != self.emailOption){
            applyEmailOptions(emailOption: emailOption)
        }
        if(commentOption != "Optional" && commentOption != self.commentOption){
            applyCommentsOption()
        }
        
        if (minCharacter != self.commentCharacterCount){
            applyMinCharacter(minCharacter: minCharacter)
        }
    
        if(attachmentsTypes != self.attachmentOptions){
            applyAttachmentOptions(attachments: attachmentsTypes)
        }
        
        if(autoScreenRecording != self.autoScreenRecording){
            applyAutoScreenRecordingOption(state: autoScreenRecording)
        }
        if(autoScreenRecording && autoScreenRecordingDuration != self.autoScreenRecordingDuration){
            applyAutoScreenRecordingDuration(duration: autoScreenRecordingDuration)
        }
        
        if(viewHierarchy1 != self.viewHierarchyOption){
            applyViewHierarchySettings(state: viewHierarchy1)
        }
        if(proactiveBugReportingState != self.proactiveBugReportingOption){
            applyProactiveBugReportingSettings(state: proactiveBugReportingState)
        }
        if(ebrFields != self.ebrFieldsOption){
            applyExtendedBugReportingSettings(State: extendedBugReportingState, Fields: ebrFields)
        }
        
    }
    
    func applyEmailOptions(emailOption: String){
        if(emailOption == "Optional" ){
            BugReporting.bugReportingOptions = [.emailFieldOptional]
            self.emailOption = "Optional"
        }else{
            BugReporting.bugReportingOptions = [.emailFieldHidden]
            self.emailOption = "Hidden"
        }
    }
    
    
    
    func applyCommentsOption(){
        BugReporting.bugReportingOptions = [.commentFieldRequired]
        self.commentOption = "Required"
    }
    
    func applyMinCharacter (minCharacter: String){
        if let characterCount = Int(minCharacter){
            BugReporting.setCommentMinimumCharacterCount(characterCount,forBugReport:  [.bug, .feedback, .question])
            self.commentCharacterCount = minCharacter
        }
    }
    
    func applyAutoScreenRecordingOption(state: Bool){
        BugReporting.autoScreenRecordingEnabled = state
        self.autoScreenRecording = state
    }
    
    func applyAutoScreenRecordingDuration(duration: String){
        if let durationInt = Double(duration){
            if(durationInt <= 30){
                BugReporting.autoScreenRecordingDuration = CGFloat(durationInt)
                self.autoScreenRecordingDuration = duration
            }
        }
    }
    
    func applyViewHierarchySettings(state: Bool){
        BugReporting.shouldCaptureViewHierarchy = state
        self.viewHierarchyOption = state
    }
    
    func applyProactiveBugReportingSettings(state: Bool){
        if(state){
            let configurations = ProactiveReportingConfigurations()
            configurations.enabled = true
            configurations.gapBetweenModals = 2
            configurations.modalDelayAfterDetection = 60
            BugReporting.setProactiveReportingConfigurations(configurations)
            self.proactiveBugReportingOption = state
        }else{
            let configurations = ProactiveReportingConfigurations()
            configurations.enabled = false
            configurations.gapBetweenModals = 2
            configurations.modalDelayAfterDetection = 60
            BugReporting.setProactiveReportingConfigurations(configurations)
            self.proactiveBugReportingOption = state
        }
    }
    
    func applyExtendedBugReportingSettings(State: Bool, Fields: String){
        
        if(State){
            if(Fields == "Required"){
                BugReporting.extendedBugReportMode = .enabledWithRequiredFields
                self.ebrFieldsOption = "Required"
            }else if(Fields == "Optional"){
                BugReporting.extendedBugReportMode = .enabledWithOptionalFields
                self.ebrFieldsOption = "Optional"
            }
            self.extendedBugReportingOption = true
        }else{
            BugReporting.extendedBugReportMode = .disabled
            self.extendedBugReportingOption = false
            self.ebrFieldsOption = "Disabled"
        }
        
    }
    
    func applyAttachmentOptions(attachments:Set<String>){
        
        
        let hasScreenshot = attachments.contains("📸")
        let hasGalleryImage = attachments.contains("🖼️")
        let hasScreenRecording = attachments.contains("🎥")
        let hasExtraScreenshot = attachments.contains("Extra 📸")
        
        switch (hasScreenshot, hasGalleryImage, hasScreenRecording, hasExtraScreenshot) {
                    
                case (true, false, false, false):
                    BugReporting.enabledAttachmentTypes = [.screenShot]
                case (false, true, false, false):
                    BugReporting.enabledAttachmentTypes = [.galleryImage]
                case (false, false, true, false):
                    BugReporting.enabledAttachmentTypes = [.screenRecording]
                case (false, false, false, true):
                    BugReporting.enabledAttachmentTypes = [.extraScreenShot]
                case (true, true, false, false):
                    BugReporting.enabledAttachmentTypes = [.screenShot, .galleryImage]
                case (true, false, true, false):
                    BugReporting.enabledAttachmentTypes = [.screenShot, .screenRecording]
                case (true, false, false, true):
                    BugReporting.enabledAttachmentTypes = [.screenShot, .extraScreenShot]
                case (false, true, true, false):
                    BugReporting.enabledAttachmentTypes = [.galleryImage, .screenRecording]
                case (false, true, false, true):
                    BugReporting.enabledAttachmentTypes = [.galleryImage, .extraScreenShot]
                case (false, false, true, true):
                    BugReporting.enabledAttachmentTypes = [.screenRecording, .extraScreenShot]
                case (true, true, true, false):
                    BugReporting.enabledAttachmentTypes = [.screenShot, .galleryImage, .screenRecording]
                case (true, true, false, true):
                    BugReporting.enabledAttachmentTypes = [.screenShot, .galleryImage, .extraScreenShot]
                case (true, false, true, true):
                    BugReporting.enabledAttachmentTypes = [.screenShot, .screenRecording, .extraScreenShot]
                case (false, true, true, true):
                    BugReporting.enabledAttachmentTypes = [.galleryImage, .screenRecording, .extraScreenShot]
                case (true, true, true, true):
                    BugReporting.enabledAttachmentTypes = [.screenShot, .galleryImage, .screenRecording, .extraScreenShot]
                default:
            BugReporting.enabledAttachmentTypes = []
                }
        self.attachmentOptions = attachments
        
    }
}
