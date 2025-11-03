//
//  SessionReplayViewModel.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import Foundation
import LuciqSDK

class SessionReplayController: ObservableObject {
    
    @Published var isEnabled = true //Session Replay is Enabled by default
    @Published var isNetworkLogsEnabled = true //Network logs are enabled by default
    @Published var isLuciqLogsEnabled = true //Luciq logs are enabled by default
    @Published var isUserStepsEnabled = true //User steps are enabled by default


    
    // Enable/Disable Session Replay
    func handleStateChange() {
        
        if isEnabled {
            SessionReplay.enabled = true
            
        } else {
            SessionReplay.enabled = false
        }
    }
    
    func applySettings(NetworkLogsState: Bool, LuciqLogsState: Bool, UserStepsState: Bool) {
        
        if(NetworkLogsState != self.isNetworkLogsEnabled){
            applyNetworkLogsState(state: NetworkLogsState)
        }
        
        if(LuciqLogsState != self.isLuciqLogsEnabled){
            applyLuciqLogsState(state: LuciqLogsState)
        }
        
        if(UserStepsState != self.isUserStepsEnabled){
            applyUserStepsState(state: UserStepsState)
        }
        
    }
    
    
    //Apply Network Logs State (enabled/ disabled)
    func applyNetworkLogsState(state: Bool){
        SessionReplay.networkLogsEnabled = state
        self.isNetworkLogsEnabled = state
    }
    
    //Apply Luciq Logs State (enabled/ disabled)
    func applyLuciqLogsState(state: Bool){
        SessionReplay.lcqLogsEnabled = state
        self.isLuciqLogsEnabled = state
    }
    
    //Apply User Steps State (enabled/ disabled)
    func applyUserStepsState(state: Bool){
        SessionReplay.userStepsEnabled = state
        self.isUserStepsEnabled = state
    }
    
    


}




