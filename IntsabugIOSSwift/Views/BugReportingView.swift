//
//  BugReportingView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 21/07/2025.
//

import SwiftUI

struct BugReportingView: View {
    
    @ObservedObject var controller: BugReportingController
    
    var body: some View {
        VStack(alignment: .leading,spacing: 25) {
            
            HStack(spacing: 0){
                
                Text("Bug Reporting:")
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
                
            if (controller.isEnabled){
                
                VStack(spacing:10){
                    
                    InvocationEventsSelector(controller: controller)
                    PromptOptions(controller: controller)
                    AdvancedSettings(controller: controller)
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


struct InvocationEventsSelector: View {
    
    @ObservedObject var controller: BugReportingController
    let invocationEvents = ["Shake","Screenshot","Two Finger Swipe","Right Edge Pan","Floating Button"]
    @State private var selectedEvents: Set<String> = []
    
    var body: some View {
        
        VStack(spacing:10){
            
            Text("Invocation Events:")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.trailing,10)
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    ForEach(invocationEvents.prefix(3), id: \.self) { event in
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
                .frame(maxWidth: .infinity, alignment: .center)
                HStack(spacing: 20) {
                    ForEach(invocationEvents.suffix(from: 3), id: \.self) { event in
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
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 10)
            
            Button(action: {
                controller.updateInvocationEvents(selectedEvents: selectedEvents)
                                }
                            ) {
                                Text("Set Invocation Events")
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

struct PromptOptions: View {
    
    @ObservedObject var controller: BugReportingController
    @State private var selectedType = "Bug"
    let reportTypes = ["Bug", "Feedback", "Question", "Full"]
    
    var body: some View {
        
        VStack(spacing: 10){
            
            Text("Prompt Options:")
                .font(Font.custom("ABCArizonaFlare-Bold", size: 30))
                .foregroundColor(Color("PrimaryColor"))
                .padding(.trailing,10)
            
            Picker("Select Report Type", selection: $selectedType) {
                            ForEach(reportTypes, id: \.self) { type in
                                Text(type)
                                    .font(Font.custom("ABCArizonaFlare-Bold", size: 16))
                                    .foregroundColor(Color("PrimaryColor"))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.top, 10)
            Button(action: {
                controller.showPrompt(promptType: selectedType)
                                }
                            ) {
                                Text("Show Prompt")
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

struct AdvancedSettings: View {
    
    @ObservedObject var controller: BugReportingController
    @State private var isExpanded = true
    @State private var selectedEmailOption : String
    @State private var selectedCommentOption :String
    @State private var commentsCharacterCount : String
    @State private var selectedAttachmentOptions: Set<String>
    @State private var selectedAutoScreenRecordingOption: Bool
    @State private var autoScreenRecordingDuration: String
    
    init(controller: BugReportingController) {
            self.controller = controller
            
            _selectedEmailOption = State(initialValue: controller.emailOption)
            _selectedCommentOption = State(initialValue: controller.commentOption)
        _commentsCharacterCount = State(initialValue: controller.commentCharacterCount)
            _selectedAttachmentOptions = State(initialValue: controller.attachmentOptions)
        _selectedAutoScreenRecordingOption = State(initialValue: controller.autoScreenRecording)
        _autoScreenRecordingDuration = State(initialValue: controller.autoScreenRecordingDuration)
        }
    
    private let attachmentOptions = ["📸","🖼️","🎥","Extra 📸"]
    
    
    var body: some View {
        
        DisclosureGroup (isExpanded: $isExpanded){
            ScrollView{
                VStack(spacing:10){
                    
                    HStack(spacing:50){
                        Text("Email Field:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                        
                        HStack(spacing:7){
                           
                            RadioButton(label: "Optional", isSelected: selectedEmailOption == "Optional") {
                                if(selectedEmailOption == "Optional"){
                                    selectedEmailOption = "Required"
                                }else{
                                    selectedEmailOption = "Optional"
                                }
                            }
                            RadioButton(label: "Hidden", isSelected: selectedEmailOption == "Hidden") {
                                if(selectedEmailOption == "Hidden"){
                                    selectedEmailOption = "Required"
                                }else{
                                    selectedEmailOption = "Hidden"
                                }
                            }
                        }
                        .frame(maxWidth: 200, alignment: .leading)

                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    
                    HStack(spacing:50){
                        Text("Comment Field:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                        
                        
                        HStack(spacing:7){
                           
                            RadioButton(label: "Required", isSelected: selectedCommentOption == "Required") {
                                if(selectedCommentOption == "Required"){
                                    selectedCommentOption = "Optional"
                                }else{
                                    selectedCommentOption = "Required"
                                }
                            }
                        }
                        .frame(maxWidth: 200, alignment: .leading)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    HStack(spacing:50){
                        Text("Comments Min Character:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                        
                        HStack(spacing:7){
                           
                            TextField("Character Count", text: $commentsCharacterCount)
                                .keyboardType(.numberPad)
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
                        .frame(maxWidth: 200, alignment: .leading)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    HStack(spacing:50){
                        Text("Attachments Options:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                        
                        HStack(spacing:3){
                           
                            VStack(spacing: 20) {
                                        HStack(spacing: 20) {
                                            ForEach(attachmentOptions.prefix(2), id: \.self) { option in
                                                Toggle(isOn: Binding(
                                                    get: { selectedAttachmentOptions.contains(option) },
                                                    set: { isSelected in
                                                        if isSelected {
                                                            selectedAttachmentOptions.insert(option)
                                                        } else {
                                                            selectedAttachmentOptions.remove(option)
                                                        }
                                                    }
                                                )) {
                                                    Text(option)
                                                        .font(Font.custom("ABCArizonaFlare-Regular", size: 16))
                                                }
                                                .toggleStyle(CheckboxToggleStyle())
                                                .frame(maxWidth: 100, alignment: .leading)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                
                                        HStack(spacing: 20) {
                                            ForEach(attachmentOptions.suffix(from: 2), id: \.self) { option in
                                                Toggle(isOn: Binding(
                                                    get: { selectedAttachmentOptions.contains(option) },
                                                    set: { isSelected in
                                                        if isSelected {
                                                            selectedAttachmentOptions.insert(option)
                                                        } else {
                                                            selectedAttachmentOptions.remove(option)
                                                        }
                                                    }
                                                )) {
                                                    Text(option)
                                                        .font(Font.custom("ABCArizonaFlare-Regular", size: 16))
                                                }
                                                .toggleStyle(CheckboxToggleStyle())
                                                .frame(maxWidth: 100, alignment: .leading)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 10)
                                
                        }
                        .frame(maxWidth: 220, alignment: .leading)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    HStack(spacing:50){
                        Text("Auto Screen Recording:")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                            .frame(maxWidth: 120, alignment: .leading)
                        
                        HStack(spacing:7){
                           
                            RadioButton(label: "Enabled", isSelected: selectedAutoScreenRecordingOption == true) {
                                if(selectedAutoScreenRecordingOption){
                                    selectedAutoScreenRecordingOption = false
                                }else{
                                    selectedAutoScreenRecordingOption = true
                                }
                            }
                            RadioButton(label: "Disabled", isSelected: selectedAutoScreenRecordingOption == false) {
                                if(!selectedAutoScreenRecordingOption){
                                    selectedAutoScreenRecordingOption = true
                                }else{
                                    selectedAutoScreenRecordingOption = false
                                }
                            }
                        }
                        .frame(maxWidth: 200, alignment: .leading)

                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    
                    if(selectedAutoScreenRecordingOption){
                       
                        HStack(spacing:50){
                            Text("Screen Recording Duration:")
                                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                                .frame(maxWidth: 120, alignment: .leading)
                            
                            HStack(spacing:7){
                               
                                TextField("Duration", text: $autoScreenRecordingDuration)
                                    .keyboardType(.numberPad)
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
                            .frame(maxWidth: 200, alignment: .leading)
                            
                        }
                        .padding(.horizontal)
                        .padding(.top,10)
                    }
                    
                    Button(action: {
                        controller.applySettings(
                            emailOption: selectedEmailOption,
                            commentOption: selectedCommentOption,
                            minCharacter: commentsCharacterCount,
                            attachmentsTypes: selectedAttachmentOptions,
                            autoScreenRecording: selectedAutoScreenRecordingOption,
                            autoScreenRecordingDuration: autoScreenRecordingDuration
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
            }.frame(height:170)
        }
            label: {
            Text("Advanced Settings")
                .font(Font.custom("ABCArizonaFlare-Medium", size: 18))
                .padding(.bottom,10)
        }
        .padding(10)
        .background(Color("TextWhite"))
        .cornerRadius(12)
    }
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


#Preview {
    BugReportingView(controller: BugReportingController())
}
