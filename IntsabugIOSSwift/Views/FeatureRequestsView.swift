//
//  FeatureRequestsView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI

struct FeatureRequestsView: View {
    
    @ObservedObject var controller : FeatureRequestsController
    @State var selectedEmailFieldForNew: Bool
    @State var selectedCommentOption: Bool
    
    init (controller : FeatureRequestsController) {
        self.controller = controller
        _selectedEmailFieldForNew = State(initialValue: controller.NewEmailFieldOption)
        _selectedCommentOption = State(initialValue: controller.CommentOption)
        
    }
    var body: some View {
        
        VStack(alignment: .leading,spacing: 25) {
            
            HStack(spacing: 0) {
                Text("Feature Requests:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 22))
                    .padding(.trailing, 10)
                
                Toggle("", isOn: $controller.isEnabled)
                    .labelsHidden()
                    .background(controller.isEnabled ? Color("SecondaryColor") : Color.red) // fixed typo
                    .cornerRadius(20)
                    .toggleStyle(SwitchToggleStyle(tint: Color("SecondaryColor")))
                    .onChange(of: controller.isEnabled, initial: true) {
                        controller.handleStateChange()
                    }
            }
            .padding(.top, 10)
            .padding(.horizontal, 15)
            
            if controller.isEnabled {
                ScrollView {
                    
                    VStack(spacing:25){
                        Button(action: {
                            controller.showFeatureRequest()}
                        ){
                            Text("Show Feature Requests")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .foregroundColor(Color("TextGray"))
                                .padding()
                                .background(Color("SecondaryColor"))
                                .cornerRadius(25)
                                .padding()
                        }
                        .padding(.top,10)
                        
                        VStack(alignment: .leading, spacing:10){
                            Text("Email field for new requests")
                                .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                                .foregroundColor(Color("PrimaryColor")).padding(.top,30)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing:50){
                                Text("Email Required:")
                                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                    .frame(maxWidth: 130, alignment: .leading)
                                    .padding(.top,10)
                                
                                HStack(spacing:7){
                                    
                                    RadioButton(label: "Enabled", isSelected: selectedEmailFieldForNew == true) {
                                        if(selectedEmailFieldForNew){
                                            selectedEmailFieldForNew = false
                                        }else{
                                            selectedEmailFieldForNew = true
                                        }
                                    }
                                    RadioButton(label: "Disabled", isSelected: selectedEmailFieldForNew == false) {
                                        if(!selectedEmailFieldForNew){
                                            selectedEmailFieldForNew = true
                                        }else{
                                            selectedEmailFieldForNew = false
                                        }
                                    }
                                }
                                .frame(maxWidth: 200, alignment: .leading)
                                .padding(.top,10)
                            }
                            .padding(.horizontal, 10)
                        }
                        VStack(alignment: .leading, spacing:10){
                            
                            Text("Email field for Comments on existing requests")
                                .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                                .foregroundColor(Color("PrimaryColor"))
                                .padding(.trailing,10)
                                .padding(.top, 30)
                            
                            HStack(spacing:50){
                                Text("Email Required:")
                                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                    .frame(maxWidth: 130, alignment: .leading)
                                    .padding(.top,10)
                                
                                HStack(spacing:7){
                                    
                                    RadioButton(label: "Enabled", isSelected: selectedCommentOption == true) {
                                        if(selectedCommentOption){
                                            selectedCommentOption = false
                                        }else{
                                            selectedCommentOption = true
                                        }
                                    }
                                    RadioButton(label: "Disabled", isSelected: selectedCommentOption == false) {
                                        if(!selectedCommentOption){
                                            selectedCommentOption = true
                                        }else{
                                            selectedCommentOption = false
                                        }
                                    }
                                }
                                .frame(maxWidth: 200, alignment: .leading)
                                .padding(.top,10)
                            }
                            .padding(10)
                            
                            Button(action: {
                                controller.applySettings(EmailFieldForNew: selectedEmailFieldForNew, EmailCommentOption: selectedCommentOption)}
                                   
                            ) {
                                Text("Save Changes")
                                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                    .foregroundColor(Color("TextGray"))
                                    .padding()
                                    .background(Color("SecondaryColor"))
                                    .cornerRadius(25)
                                    .padding()
                            }
                            .padding(.top,10)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal){
                Image("LuciqLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 60)
                    .clipped()
                    .padding(.top,5)
                    .padding(.bottom,12)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color("PrimaryColor"), for: .navigationBar)
    }
}
    #Preview {
        FeatureRequestsView(controller: FeatureRequestsController())
    }

