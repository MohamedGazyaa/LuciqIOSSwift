//
//  SurveysView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI

struct SurveysView: View {
    
    @ObservedObject var controller: SurveysController
    @State private var surveyToken = ""
    @State private var autoShowingSelection: Bool
    @State private var welcomeMessageSelection: Bool
    
    init(controller: SurveysController) {
        self.controller = controller
        _autoShowingSelection = State(initialValue: controller.autoShowingOption)
        _welcomeMessageSelection = State(initialValue: controller.welcomeMessageOption)
    }
    
    
    var body: some View {
        VStack(alignment: .leading,spacing: 25) {
            
            HStack(spacing: 0){
                
                Text("Surveys:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 22))
                    .padding(.trailing,10)
                Toggle("", isOn: $controller.isEnabled)
                    .labelsHidden()
                    .background(controller.isEnabled ? Color("SecondaryColor") : Color.red)
                    .cornerRadius(20)
                    .toggleStyle(SwitchToggleStyle(tint: Color("SecondaryColor")))
                    .onChange(of: controller.isEnabled, initial: true) {
                        controller.handleStateChange()
                    }
            }
            .padding()
            
            if(controller.isEnabled){
                
                VStack(spacing:15){
                    
                    VStack(alignment: .leading, spacing:10){
                        Text("Manually-Targeted Surveys:")
                            .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.trailing,10)
                        
                        HStack(spacing:50){
                            Text("Survey Token:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 120, alignment: .leading)
                            
                            HStack(spacing:7){
                                
                                TextField("Survey Token", text: $surveyToken)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 5)
                                    .background(Color("TextWhite"))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray, lineWidth: 0.2)
                                    )
                                    .padding(.horizontal, 5)
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            
                        }
                        .padding(.horizontal)
                        .padding(.top,10)
                        
                        Button(action: {
                            controller.showManualSurvey(token: surveyToken)
                        }
                        ) {
                            Text("Show Survey")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .foregroundColor(Color("TextGray"))
                                .padding()
                                .background(Color("SecondaryColor"))
                                .cornerRadius(25)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    VStack(alignment: .leading, spacing:10){
                        Text("Auto-Showing Surveys:")
                            .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.trailing,10)
                        
                        HStack(spacing:50){
                            Text("Auto-showing of Surveys:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 110, alignment: .leading)
                            
                            HStack(spacing:7){
                                
                                RadioButton(label: "Enabled", isSelected: autoShowingSelection == true) {
                                    if(autoShowingSelection){
                                        autoShowingSelection = false
                                    }else{
                                        autoShowingSelection = true
                                    }
                                }
                                RadioButton(label: "Disabled", isSelected: autoShowingSelection == false) {
                                    if(!autoShowingSelection){
                                        autoShowingSelection = true
                                    }else{
                                        autoShowingSelection = false
                                    }
                                }
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            
                        }
                        .padding(.horizontal)
                        .padding(.top,10)
                        
                        if(!controller.autoShowingOption){
                            Button(action: {
                                controller.showManualSurvey(token: surveyToken)
                                surveyToken = ""
                            }
                            ) {
                                Text("Show Survey")
                                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                    .foregroundColor(Color("TextGray"))
                                    .padding()
                                    .background(Color("SecondaryColor"))
                                    .cornerRadius(25)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing:10){
                        Text("Surveys Welcome Message:")
                            .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.trailing,10)
                        
                        HStack(spacing:50){
                            Text("Welcome Message:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 110, alignment: .leading)
                            
                            HStack(spacing:7){
                                
                                RadioButton(label: "Enabled", isSelected: welcomeMessageSelection == true) {
                                    if(welcomeMessageSelection){
                                        welcomeMessageSelection = false
                                    }else{
                                        welcomeMessageSelection = true
                                    }
                                }
                                RadioButton(label: "Disabled", isSelected: welcomeMessageSelection == false) {
                                    if(!welcomeMessageSelection){
                                        welcomeMessageSelection = true
                                    }else{
                                        welcomeMessageSelection = false
                                    }
                                }
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            
                        }
                        .padding(.horizontal)
                        .padding(.top,10)
                    }
                    Button(action: {
                        controller.applySettings(
                            autoShowingState: autoShowingSelection, welcomeMessageState: welcomeMessageSelection
                        )
                                        }
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
                }
                .padding(10)
            }
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
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
    
    struct RadioButton: View {
        var label: String
        var isSelected: Bool
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                HStack {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(isSelected ? Color("PrimaryColor") : .gray)
                    Text(label)
                        .font(Font.custom("ABCArizonaFlare-Regular", size: 16))
                }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    SurveysView(controller: SurveysController())
}
