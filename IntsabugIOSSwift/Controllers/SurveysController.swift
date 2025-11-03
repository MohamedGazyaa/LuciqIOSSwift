//
//  SurveysViewModel.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import Foundation
import LuciqSDK

class SurveysController: ObservableObject{
    
    @Published var isEnabled = true
    @Published var autoShowingOption = true
    @Published var welcomeMessageOption = true
    
    func handleStateChange(){
        if isEnabled {
            Surveys.enabled = true
        } else {
            Surveys.enabled = false
        }
    }
    
    func showManualSurvey(token: String){
        Surveys.showSurvey(withToken: token)
    }
    
    func applySettings(autoShowingState: Bool, welcomeMessageState: Bool){
        if(autoShowingState != self.autoShowingOption){
            Surveys.autoShowingEnabled = autoShowingState
            self.autoShowingOption = autoShowingState
        }
        if(welcomeMessageState != self.welcomeMessageOption){
            Surveys.shouldShowWelcomeScreen = welcomeMessageState
            self.welcomeMessageOption = welcomeMessageState
        }
    }
}
