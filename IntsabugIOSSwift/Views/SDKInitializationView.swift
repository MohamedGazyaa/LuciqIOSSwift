//
//  SDKInitializationView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 29/09/2025.
//

import SwiftUI

struct SDKInitializationView: View {
    
    @State private var appToken = ""
    @State private var showAlert = false
    @State private var showAdvanced = false
    @State private var selectedEvents: Set<String> = []
    var controller = SDKInitializationController()
    
    let invocationEvents = [
        "Shake",
        "Screenshot",
        "Two Finger Swipe",
        "Right Edge Pan",
        "Floating Button"
    ]
    
    var body: some View {
        
        
        VStack(spacing: 0) {
                    // Custom header (toolbar style)
                    HStack {
                        Spacer()
                        Image("LuciqLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 60)
                            .clipped()
                            .padding(.bottom,12)
                        Spacer()
                    }
                    .frame(height: 55)
                    .background(Color("PrimaryColor"))

                    Spacer() // Your content area
            VStack( spacing: 15){
                
                Text("SDK initialization")
                    .font(Font.custom("ABCArizonaFlare-Bold", size: 20))
                
                HStack(){
                    
                    Text("App Token:")
                        .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    
                    TextField("Your App Token", text: $appToken)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color("TextWhite"))
                        .cornerRadius(12)
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 0.2)
                            )
                        .padding(.horizontal, 7)
                }
                .padding(15)
                
                DisclosureGroup(
                    isExpanded: $showAdvanced
                ) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Select Invocation Events:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                        
                        ForEach(invocationEvents, id: \.self) { event in
                            Toggle(isOn: Binding(
                                get: { selectedEvents.contains(event) },
                                set: { isSelected in
                                    if isSelected {
                                        selectedEvents.insert(event)
                                    } else {
                                        selectedEvents.remove(event)
                                    }
                                }
                            )) {
                                Text(event)
                                    .font(Font.custom("ABCArizonaFlare-Regular", size: 16))
                            }
                            .toggleStyle(CheckboxToggleStyle())
                        }
                    }
                    .padding(.vertical, 5)
                } label: {
                    Text("Advanced Settings")
                        .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                Button(action: {
                                    let success = controller.handleSubmit(inputText: appToken, selectedEvents: selectedEvents)
                                    if !success {
                                        showAlert = true
                                    }
                                }) {
                                    Text("Initialize the SDK")
                                        .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                        .foregroundColor(Color("TextGray"))
                                        .padding()
                                        .background(Color("SecondaryColor"))
                                        .cornerRadius(25)
                                        .padding()
                                }
                                .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Missing Token ⚠️"),
                                        message: Text("Please enter your App Token before initializing the SDK."),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                                
                            }
            .padding(.vertical, 15)
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding(30)
                    Spacer()
        }.background(Color("TextWhite"))
    }
}

#Preview {
    SDKInitializationView()
}
