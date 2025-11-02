// CrashReportingView.swift
// IntsabugIOSSwift
//
// Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI

struct CrashReportingView: View {

    @ObservedObject var controller: CrashReportingController

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {

                // Top toggle row for enable/disable
                HStack(spacing: 0){
                    Text("Crash Reporting:")
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
                        
                        ManualException(controller: controller)
                        ManualError(controller: controller)
                        FatalCrash(controller: controller)
                        CrashAdvancedSettings(controller: controller)
                        
                        
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

struct ManualException: View {
    @ObservedObject var controller: CrashReportingController
    var body: some View {
        // Manual Exception Section
        VStack(spacing:10){
            
            //Report Manual Exception with Level Selection
            Text("Report a Manual Exception")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                .foregroundColor(Color("PrimaryColor"))

            Text("Level:")
                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))

            Picker("Select Level", selection: $controller.exceptionLevel) {
                ForEach(CrashLevel.allCases) { level in
                    Text(level.rawValue)
                        .font(Font.custom("ABCArizonaFlare-Bold", size: 16))
                        .foregroundColor(Color("PrimaryColor"))
                        .tag(level)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 10)

            Button(action: {
                controller.reportManualException()
            }) {
                Text("Report Exception")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .foregroundColor(Color("TextGray"))
                    .padding()
                    .background(Color("SecondaryColor"))
                    .cornerRadius(25)
                    .padding()
            }
        }
    }
}

struct ManualError: View {
    @ObservedObject var controller: CrashReportingController
    var body: some View {
        // Manual Error Section
        VStack(spacing:10){
            
            //Report Manual Error with Level Selection
            Text("Report a Manual Error")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                .foregroundColor(Color("PrimaryColor"))

            Text("Level:")
                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))

            Picker("Select Level", selection: $controller.errorLevel) {
                ForEach(CrashLevel.allCases) { level in
                    Text(level.rawValue)
                        .font(Font.custom("ABCArizonaFlare-Bold", size: 16))
                        .foregroundColor(Color("PrimaryColor"))
                        .tag(level)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 10)

            Button(action: {
                //controller.reportManualError()
            }) {
                Text("Report Error")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .foregroundColor(Color("TextGray"))
                    .padding()
                    .background(Color("SecondaryColor"))
                    .cornerRadius(25)
                    .padding()
            }
        }
    }
}

struct FatalCrash: View {
    @ObservedObject var controller: CrashReportingController
    var body: some View {
        // Report Fatal Crash
        VStack(spacing:10){
            
            //Report Manual Error with Level Selection
            Text("Report a Fatal Crash")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                .foregroundColor(Color("PrimaryColor"))


            Button(action: {
                controller.triggerFatal()
            }) {
                Text("Report Crash")
                    .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                    .foregroundColor(Color("TextGray"))
                    .padding()
                    .background(Color("SecondaryColor"))
                    .cornerRadius(25)
                    .padding()
            }
        }
    }
}
  
            
                
struct CrashAdvancedSettings: View {
    @ObservedObject var controller: CrashReportingController
    @State private var isExpanded = false
    @State private var selectedStackTraceMode: StackTraceMode
    @State private var selectedOOMState: Bool
    @State private var selectedAppHangsState: Bool
    @State private var selectedForceRestartsState: Bool
    @State private var fingerprintingEnabled: Bool
    @State private var fingerprintText: String
    @State private var fingerprintError: String?
     

    init(controller: CrashReportingController) {
        self.controller = controller
        _selectedStackTraceMode = State(initialValue: controller.stackTraceMode)
        _selectedOOMState = State(initialValue: controller.isOOMEnabled)
        _selectedAppHangsState = State(initialValue: controller.isAppHangsEnabled)
        _selectedForceRestartsState = State(initialValue: controller.isForceRestartsEnabled)
        _fingerprintingEnabled = State(initialValue: controller.isCustomFingerprintingEnabled)
        _fingerprintText = State(initialValue: controller.groupingString)
    }

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            ScrollView{
                VStack(spacing:10) {
                    
                    //Stack trace mode

                    HStack(spacing:50){
                        Text("Stack Trace Mode:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)

                        HStack(spacing:7){
                            RadioButton(label: "Full",
                                        isSelected: selectedStackTraceMode == .full) {
                                selectedStackTraceMode = .full
                            }
                            RadioButton(label: "Current Thread",
                                        isSelected: selectedStackTraceMode == .callerThread) {
                                selectedStackTraceMode = .callerThread
                            }
                        }
                        .frame(maxWidth: 200, alignment: .leading)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    
                    //OOM
                    
                    HStack(spacing: 50) {
                        Text("Detect OOM crashes:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                        
                        HStack(spacing: 7) {
                            RadioButton(label: "Enable",
                                        isSelected: selectedOOMState) {
                                selectedOOMState = true
                            }
                            RadioButton(label: "Disable",
                                        isSelected: !selectedOOMState) {
                                selectedOOMState = false
                            }
                        }
                        .frame(maxWidth: 200, alignment: .leading)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    //App Hangs
                    
                    HStack(spacing: 50) {
                        Text("Detect App Hangs:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                                        
                        HStack(spacing: 7) {
                            RadioButton(label: "Enable",
                                        isSelected: selectedAppHangsState) {
                                selectedAppHangsState = true
                            }
                            RadioButton(label: "Disable",
                                        isSelected: !selectedAppHangsState) {
                                selectedAppHangsState = false
                            }
                        }
                        .frame(maxWidth: 200, alignment: .leading)
                                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    //Force Restarts
                    
                    HStack(spacing: 50) {
                        Text("Force App Restarts:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                                        
                        HStack(spacing: 7) {
                            RadioButton(label: "Enable",
                                        isSelected: selectedForceRestartsState) {
                                selectedForceRestartsState = true
                            }
                            RadioButton(label: "Disable",
                                        isSelected: !selectedForceRestartsState) {
                                selectedForceRestartsState = false
                            }
                        }
                        .frame(maxWidth: 200, alignment: .leading)
                                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    //Custom Fingerprinting
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 50) {
                            Text("Custom Fingerprinting:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 120, alignment: .leading)

                            HStack(spacing: 7) {
                                RadioButton(label: "OFF",
                                            isSelected: !fingerprintingEnabled) {
                                    fingerprintingEnabled = false
                                    fingerprintError = nil
                                }
                                RadioButton(label: "ON",
                                            isSelected: fingerprintingEnabled) {
                                    fingerprintingEnabled = true
                                }
                            }
                            .frame(maxWidth: 200, alignment: .leading)
                        }
                        
                        if fingerprintingEnabled {
                            VStack(alignment: .leading, spacing: 6) {
                                TextField("Enter grouping key", text: $fingerprintText)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color("TextWhite"))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray, lineWidth: 0.2)
                                    )

                                if let error = fingerprintError {
                                    Text(error)
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.leading, 50)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                        
                        
                    
                    
                    

                    Button(action: {
                        
                        fingerprintError = nil
                        let trimmedFingerprint = fingerprintText.trimmingCharacters(in: .whitespacesAndNewlines)

                        if fingerprintingEnabled && trimmedFingerprint.isEmpty {
                            fingerprintError = "Fingerprint cannot be empty when enabled."
                            return
                        }
                        
                        controller.applySettings(stackTraceMode: selectedStackTraceMode,
                                                 OOMState: selectedOOMState,
                                                 fingerprintingEnabled: fingerprintingEnabled,
                                                 fingerprint: fingerprintingEnabled ? trimmedFingerprint : fingerprintText,
                                                 appHangsState: selectedAppHangsState,
                                                 forceRestartsState: selectedForceRestartsState)
                    }) {
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
            }.frame(height:170)
            
        } label: {
            Text("Advanced Settings")
                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                .padding(.bottom,10)
        }
        .padding(10)
        .background(Color("TextWhite"))
        .cornerRadius(12)
    }
}



#Preview {
    CrashReportingView(controller: CrashReportingController())
}
