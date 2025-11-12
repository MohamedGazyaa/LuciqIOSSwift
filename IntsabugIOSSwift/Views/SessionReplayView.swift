//
//  SessionReplayView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI

struct SessionReplayView: View {

    @ObservedObject var controller: SessionReplayController

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {

                // Top toggle row for enable/disable
                HStack(spacing: 0){
                    Text("Session Replay:")
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

                if (controller.isEnabled) {
                    
                    VStack(spacing:10){
                        
                        //Add sections
                        SessionReplaySettings(controller: controller)
                        

                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }

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
                        .font(Font.custom("ABCArizonaFlare-Regular", size: 15))
                }
            }
            .buttonStyle(.plain)
        }
    }
}

struct SessionReplaySettings: View {
    @ObservedObject var controller: SessionReplayController
    //@State private var isExpanded = false
    @State private var selectedNetworkLogsState: Bool
    @State private var selectedLuciqLogsState: Bool
    @State private var selectedUserStepsState: Bool

     

    init(controller: SessionReplayController) {
        self.controller = controller
        _selectedNetworkLogsState = State(initialValue: controller.isNetworkLogsEnabled)
        _selectedLuciqLogsState = State(initialValue: controller.isLuciqLogsEnabled)
        _selectedUserStepsState = State(initialValue: controller.isUserStepsEnabled)
    }

    var body: some View {
        VStack(spacing: 10) {
            Text("Session Replay Settings:")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 25))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Network Logs:")
                        .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                        .foregroundColor(Color("PrimaryColor"))

                    HStack(spacing: 20) {
                        SessionReplayView.RadioButton(
                            label: "Enable",
                            isSelected: selectedNetworkLogsState
                        ) {
                            selectedNetworkLogsState = true
                        }
                        SessionReplayView.RadioButton(
                            label: "Disable",
                            isSelected: !selectedNetworkLogsState
                        ) {
                            selectedNetworkLogsState = false
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Luciq Logs:")
                        .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                        .foregroundColor(Color("PrimaryColor"))

                    HStack(spacing: 20) {
                        SessionReplayView.RadioButton(
                            label: "Enable",
                            isSelected: selectedLuciqLogsState
                        ) {
                            selectedLuciqLogsState = true
                        }
                        SessionReplayView.RadioButton(
                            label: "Disable",
                            isSelected: !selectedLuciqLogsState
                        ) {
                            selectedLuciqLogsState = false
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("User Steps:")
                        .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                        .foregroundColor(Color("PrimaryColor"))

                    HStack(spacing: 20) {
                        SessionReplayView.RadioButton(
                            label: "Enable",
                            isSelected: selectedUserStepsState
                        ) {
                            selectedUserStepsState = true
                        }
                        SessionReplayView.RadioButton(
                            label: "Disable",
                            isSelected: !selectedUserStepsState
                        ) {
                            selectedUserStepsState = false
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            Button(action: {
                controller.applySettings(
                    NetworkLogsState: selectedNetworkLogsState,
                    LuciqLogsState: selectedLuciqLogsState,
                    UserStepsState: selectedUserStepsState
                )
            }) {
                Text("Save Changes")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .foregroundColor(Color("TextGray"))
                    .padding()
                    .background(Color("SecondaryColor"))
                    .cornerRadius(25)
                    .padding()
            }
            .padding(.top, 10)
        }
    }
}


#Preview {
    SessionReplayView(controller: SessionReplayController())
}

