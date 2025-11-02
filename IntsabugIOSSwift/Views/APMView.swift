//
//  APMView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI





struct APMView: View {
    // Use ObservedObject for a shared singleton
    @ObservedObject var controller :  APMController
    @State var selectedColdAppLaunch: Bool
    @State var selectedHotAppLaunch: Bool
    @State var selectedUIHangs: Bool
    @State var selectedScreenLoading: Bool
    @State var selectedWebviews: Bool
    
    init (controller : APMController) {
        self.controller = controller
        _selectedColdAppLaunch = State(initialValue: controller.ColdApplaunchOption)
        _selectedHotAppLaunch = State(initialValue: controller.HotApplaunchOption)
        _selectedUIHangs = State(initialValue: controller.UIHangsOption)
        _selectedScreenLoading = State(initialValue: controller.ScreenLoadingOption)
        _selectedWebviews = State(initialValue: controller.WebviewsOption)
    }
    
    var body: some View {
        
       
        VStack (alignment: .leading, spacing: 25) {
            
            // Adding a toggle button to Enable and disable APM
            
            HStack(spacing: 0) {
                Text("APM:")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 22))
                    .padding(.trailing, 10)
                
                Toggle("", isOn: $controller.isEnabled)
                    .labelsHidden()
                    .background(controller.isEnabled ? Color("SecondayColor") : Color.red)
                    .cornerRadius(20)
                    .toggleStyle(SwitchToggleStyle(tint: Color("SecondaryColor")))
                    .onChange(of: controller.isEnabled, initial: true) {
                        controller.handleStateChange()
                    }
                
                
            }
            .padding(.top,10)
            .padding(.horizontal, 15)
            
            // End of the toggle button to Enable and disable APM
            
            if (controller.isEnabled){
                ScrollView{
                    
                    
                    VStack (alignment: .center, spacing: 20) {
                        
                        Text("App Launch")
                            .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.top, 30)

                        
                        
                        //Cold App Launch Radio button start
                        HStack(spacing:50){
                            Text("Cold Launch:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 120, alignment: .leading)
                            
                            HStack(spacing:7){
                                
                                RadioButton(label: "Enabled", isSelected: selectedColdAppLaunch == true) {
                                    if(selectedColdAppLaunch){
                                        selectedColdAppLaunch = false
                                    }else{
                                        selectedColdAppLaunch = true
                                    }
                                }
                                RadioButton(label: "Disabled", isSelected: selectedColdAppLaunch == false) {
                                    if(!selectedColdAppLaunch){
                                        selectedColdAppLaunch = true
                                    }else{
                                        selectedColdAppLaunch = false
                                    }
                                }
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            
                            
                        }

                        .padding(.top,10)
                        
                        //Hot App Launch Radio button start
                        HStack(spacing:50){
                            Text("Hot Launch:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 120, alignment: .leading)
                            
                            HStack(spacing:7){
                                
                                RadioButton(label: "Enabled", isSelected: selectedHotAppLaunch == true) {
                                    if(selectedHotAppLaunch){
                                        selectedHotAppLaunch = false
                                    }else{
                                        selectedHotAppLaunch = true
                                    }
                                }
                                RadioButton(label: "Disabled", isSelected: selectedHotAppLaunch == false) {
                                    if(!selectedHotAppLaunch){
                                        selectedHotAppLaunch = true
                                    }else{
                                        selectedHotAppLaunch = false
                                    }
                                }
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            
                            
                            
                            
                        }

                        .padding(.top,10)
                        
                        //Hot App Launch Radio button end
                        
                        
                        //UI hangs start
                        Text("UI Hangs")
                            .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.top, 30)
                            .padding(.horizontal)
                        
                        HStack(spacing:50){
                            Text("UI Hangs:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 120, alignment: .leading)
                            
                            HStack(spacing:7){
                                
                                RadioButton(label: "Enabled", isSelected: selectedUIHangs == true) {
                                    if(selectedUIHangs){
                                        selectedUIHangs = false
                                    }else{
                                        selectedUIHangs = true
                                    }
                                }
                                RadioButton(label: "Disabled", isSelected: selectedUIHangs == false) {
                                    if(!selectedUIHangs){
                                        selectedUIHangs = true
                                    }else{
                                        selectedUIHangs = false
                                    }
                                }
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            
                            
                            
                            
                        }
                        .padding(.top,10)
                        //UI hangs End
                        
                        //Screen Loading start
                        
                        Text("Screen Loading")
                            .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(.top, 30)
                            .padding(.horizontal)
                        
                        
                        HStack(spacing:50){
                            
                            Text("Screen Loading:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 130, alignment: .leading)
                            
                            HStack(spacing:7){
                                
                                RadioButton(label: "Enabled", isSelected: selectedScreenLoading == true) {
                                    if(selectedScreenLoading){
                                        selectedScreenLoading = false
                                        selectedWebviews = false
                                    }else{
                                        selectedScreenLoading = true
                                    }
                                }
                                RadioButton(label: "Disabled", isSelected: selectedScreenLoading == false) {
                                    if(!selectedScreenLoading){
                                        selectedScreenLoading = true
                                    }else{
                                        selectedScreenLoading = false
                                        selectedWebviews = false
                                        
                                    }
                                }
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                            
                            
                            
                            
                        }

                        .padding(.top,10)
                        //Screen Loading End
                        
                        if(selectedScreenLoading){
                            
                            HStack(spacing:50){
                                
                                Text("Webviews Tracking:")
                                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                    .frame(maxWidth: 130, alignment: .leading)
                                
                                HStack(spacing:7){
                                    
                                    RadioButton(label: "Enabled", isSelected: selectedWebviews == true) {
                                        if(selectedWebviews){
                                            selectedWebviews = false
                                        }else{
                                            selectedWebviews = true
                                        }
                                    }
                                    RadioButton(label: "Disabled", isSelected: selectedWebviews == false) {
                                        if(!selectedWebviews){
                                            selectedWebviews = true
                                        }else{
                                            selectedWebviews = false
                                        }
                                    }
                                }
                                .frame(maxWidth: 200, alignment: .leading)
                            }
                            .padding(.top,10)
                            
                        }
                        
                        Button(action: {
                            controller.applySettings(ColdApplaunch: selectedColdAppLaunch, HotApplaunch: selectedHotAppLaunch, UIHangs: selectedUIHangs, ScreenLoading: selectedScreenLoading, Webviews: selectedWebviews)}
                               
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
                    .padding (.horizontal, 15)
                }
            }
            //                           }.frame(height:170)
            //                       }
            //                           label: {
            //                           Text("Advanced Settings")
            //                               .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
            //                               .padding(.bottom,10)
            //                       }
            //                       .padding(10)
            //                       .background(Color("TextWhite"))
            //                       .cornerRadius(12)
            //                   }
            
            
            
            
            
            
            
            
            
        }
        
        
        // starting at the top of the page
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
    
    //Radio button Design
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
    //Radio button Design
    
}
    


#Preview {
    APMView(controller: APMController())
}

