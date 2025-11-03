//
//  FeatureRequestsViewModel.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import Foundation
import LuciqSDK
class FeatureRequestsController: ObservableObject{
    
    @Published var isEnabled = true
    @Published var NewEmailFieldOption = true
    @Published var CommentOption = true
    
    
    func handleStateChange() {
        if isEnabled {
            FeatureRequests.enabled = true

        } else {
            FeatureRequests.enabled = false
        }
    }
    
 func showFeatureRequest(){
    FeatureRequests.show()    }
    
    func applySettings(EmailFieldForNew: Bool, EmailCommentOption:Bool ){
                if(EmailFieldForNew != self.NewEmailFieldOption){
                            ApplyEmailFieldForNew(state: EmailFieldForNew)
                        }
        if(EmailCommentOption != self.CommentOption){
                    ApplyEmailCommentOption(state: EmailCommentOption)
                }
     
                }
    func ApplyEmailFieldForNew (state: Bool){
        FeatureRequests.setEmailFieldRequired(true, for: [.requestNewFeature])
                        self.NewEmailFieldOption = state
                }
    
    func ApplyEmailCommentOption (state: Bool){
        FeatureRequests.setEmailFieldRequired(true, for: [.addCommentToFeature])
                        self.CommentOption = state
                }

    
}
    
    
