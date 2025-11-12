//
//  SDKSettings.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI

struct SDKSettings: View {
    
    @ObservedObject var controller: SDKSettingsController
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack(spacing: 0){
                Text("Luciq SDK:")
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
            
            ScrollView{
                if(controller.isEnabled){
                    userIdentification(controller: controller)
                    userAttribute(controller: controller)
                    welcomeMessage(controller: controller)
                }
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
}

struct userIdentification: View{
    
    @ObservedObject var controller: SDKSettingsController
    @State private var showAlert = false
    @State private var userIdentificationInputName: String
    @State private var userIdentificationInputEmail: String
    @State private var userIdentificationInputID: String
    
    init(controller: SDKSettingsController) {
        self.controller = controller
        _userIdentificationInputName = State(initialValue: controller.userIdentificationName)
        _userIdentificationInputEmail = State(initialValue: controller.userIdentificationEmail)
        _userIdentificationInputID = State(initialValue: controller.userIdentificationID)
    }
    
    
    var body: some View{
        
        VStack(alignment: .leading, spacing:10){
            Text("User Identification:")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.trailing,10)
            
            HStack(spacing:50){
                Text("User Name:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .frame(maxWidth: 120, alignment: .leading)
                
                HStack(spacing:7){
                    
                    TextField("user name", text: $userIdentificationInputName)
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
            
            HStack(spacing:50){
                Text("Email:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .frame(maxWidth: 120, alignment: .leading)
                
                HStack(spacing:7){
                    
                    TextField("user email", text: $userIdentificationInputEmail)
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
            
            HStack(spacing:50){
                Text("ID:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .frame(maxWidth: 120, alignment: .leading)
                
                HStack(spacing:7){
                    
                    TextField("user ID", text: $userIdentificationInputID)
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
                let success = controller.identifyUser(name: userIdentificationInputName, ID: userIdentificationInputID, Email: userIdentificationInputEmail)
                if (!success){
                    showAlert = true
                }
            }) {
                Text("Identify User")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .foregroundColor(Color("TextGray"))
                    .padding()
                    .background(Color("SecondaryColor"))
                    .cornerRadius(25)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Input ⚠️"),
                    message: Text("Please ensure that both the email and ID are not empty"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct userAttribute: View {
    
    @ObservedObject var controller: SDKSettingsController
    @State private var showAlert = false
    @State private var attributeKeyInput = ""
    @State private var attributeValueInput = ""
    
    var body: some View{
        
        VStack(alignment: .leading, spacing:10){
            Text("User Identification:")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.trailing,10)
            
            HStack(spacing:50){
                Text("Key:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .frame(maxWidth: 120, alignment: .leading)
                
                HStack(spacing:7){
                    
                    TextField("Attribute key", text: $attributeKeyInput)
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
            
            HStack(spacing:50){
                Text("Value:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .frame(maxWidth: 120, alignment: .leading)
                
                HStack(spacing:7){
                    
                    TextField("Attribute value", text: $attributeValueInput)
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
                let success = controller.addUserAttirbute(key: attributeKeyInput, value: attributeValueInput)
                if (success){
                    attributeKeyInput = ""
                    attributeValueInput = ""
                }else{
                    showAlert = true
                }
                
            }) {
                Text("Add Attribute")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .foregroundColor(Color("TextGray"))
                    .padding()
                    .background(Color("SecondaryColor"))
                    .cornerRadius(25)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Input ⚠️"),
                    message: Text("Please ensure that both the Key and Value are not empty"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct welcomeMessage: View{
    
    @ObservedObject var controller: SDKSettingsController
    let welcomeMessageModes = ["Live", "Beta", "Disabled"]
    @State private var selectedMode: String
    
    init(controller: SDKSettingsController) {
        self.controller = controller
        _selectedMode = State(initialValue: controller.welcomeMessageMode)
    }
    
    var body: some View{
        
        VStack(alignment: .leading, spacing:10){
            Text("Welcome Message:")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.trailing,10)
            
            HStack(spacing:50){
                Text("Mode:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .frame(maxWidth: 60, alignment: .leading)
                
                HStack(spacing:7){
                    Picker("Select Report Type", selection: $selectedMode) {
                        ForEach(welcomeMessageModes, id: \.self) { mode in Text(mode)
                                            .font(Font.custom("ABCArizonaFlare-Bold", size: 16))
                                            .foregroundColor(Color("PrimaryColor"))
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.top, 10)
                }
                .frame(maxWidth: 290, alignment: .leading)
                
            }
            .padding(.horizontal)
            .padding(.top,10)
            
            Button(action: {
                controller.setWelcomeMessageMode(mode: selectedMode)
            }) {
                Text("Save Changes")
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
}

#Preview {
    SDKSettings(controller: SDKSettingsController())
}
