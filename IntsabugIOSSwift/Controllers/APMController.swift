//
//  APMController.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import Foundation
import LuciqSDK


// APM Enabled or disabled
class APMController: ObservableObject {
    
    @Published var isEnabled = true
    @Published var uiHangs = true
    @Published var ColdApplaunchOption = true
    @Published var HotApplaunchOption = true
    @Published var UIHangsOption = true
    @Published var ScreenLoadingOption = true
    @Published var WebviewsOption = true
    
    func handleStateChange() {
        if isEnabled {
            APM.enabled = true
        } else {
            APM.enabled = false
        }
    }
    
    
    func applySettings(ColdApplaunch: Bool, HotApplaunch:Bool, UIHangs:Bool, ScreenLoading:Bool, Webviews:Bool ){
                if(ColdApplaunch != self.ColdApplaunchOption){
                            ApplyColdAppLaunchSettings(state: ColdApplaunch)
                        }
        if(HotApplaunch != self.HotApplaunchOption){
                    ApplyHotAppLaunchSettings(state: HotApplaunch)
                }
        if(UIHangs != self.UIHangsOption){
                    ApplyUIHangsSettings(state: UIHangs)
                }
        if(ScreenLoading != self.ScreenLoadingOption){
                    ApplyScreenLoadingSettings(state: ScreenLoading)
                }
        if(Webviews != self.WebviewsOption){
                    ApplyWebviewsSettings(state: Webviews)
                }
            }
        
    
    //Each function calls a Luciq API
    
    func ApplyColdAppLaunchSettings(state: Bool){
                APM.coldAppLaunchEnabled = state
                        self.ColdApplaunchOption = state
                }
    func ApplyHotAppLaunchSettings(state: Bool){
        APM.hotAppLaunchEnabled = state
                self.HotApplaunchOption = state
        }

    func ApplyUIHangsSettings(state: Bool){
         APM.uiHangsEnabled = state
                self.UIHangsOption = state
        }
    
    func ApplyScreenLoadingSettings(state: Bool){
        APM.screenLoadingEnabled  = state
                self.ScreenLoadingOption = state
        }
    
    //Not sure if this is correct
    
    func ApplyWebviewsSettings(state: Bool){
        
        APM.webViewTrackingEnabled  = state
        self.WebviewsOption = state
        
    }
        
}
