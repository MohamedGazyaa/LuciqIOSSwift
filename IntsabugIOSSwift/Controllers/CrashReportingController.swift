// CrashReportingController.swift
// IntsabugIOSSwift
//
// Created by Mohamed Gazya on 22/07/2025.
//

import Foundation
import LuciqSDK

enum CrashLevel: String, CaseIterable, Identifiable {
    case critical = "Critical"
    case warning  = "Warning"
    case error    = "Error"
    case information = "Information"
    var id: String { rawValue }
}


enum StackTraceMode: String, CaseIterable, Identifiable {
    case full = "Full"
    case callerThread = "Caller Thread"
    var id: String { rawValue }
}

class CrashReportingController: ObservableObject {

    // Main switches
    @Published var isEnabled = true //Crash Reporting is Enabled by default
    @Published var isOOMEnabled = true //OOMs are enabled by default
    @Published var isAppHangsEnabled = true //App hangs are enabled by default
    @Published var isForceRestartsEnabled = true //Force Restarts are enabled by default
    // Non‑fatal selections
    @Published var exceptionLevel: CrashLevel = .error //for report a manual exception
    @Published var errorLevel: CrashLevel = .critical   //for report a manual error
    @Published var stackTraceMode: StackTraceMode = .full
    @Published var groupingString: String = "com.service.method.some_exception"
    @Published var isCustomFingerprintingEnabled = false


    // Enable/Disable Crash Reporting
    func handleStateChange() {
        if isEnabled {
            CrashReporting.enabled = true
            
        } else {
            CrashReporting.enabled = false
        }
    }

  



    // Report a manual exception WITH level, grouping, and attributes
    func reportManualException() {
        let exception = NSException(
            name: NSExceptionName("some_exception"),
            reason: "Exception reason"
        )
        if let nonFatalException = CrashReporting.exception(exception) {
            nonFatalException.userAttributes = [
                "hello": "world"
            ]
            
            //Custom FingerPrinting
            nonFatalException.groupingString = self.groupingString
            
            //Select Level
            switch exceptionLevel {
            case .critical:     nonFatalException.level = .critical
            case .warning:      nonFatalException.level = .warning
            case .error:        nonFatalException.level = .error
            case .information:  nonFatalException.level = .info
            }
            
            //
            switch stackTraceMode {
            case .full:         nonFatalException.stackTraceMode = .full
            case .callerThread: nonFatalException.stackTraceMode = .callerThread
            }
            
            nonFatalException.report()
        
            
        }
    
    }
    

    // Manual Error
    func reportManualError() {
     
     let domain = "com.service.method"
     let code = 0
     let error = NSError(domain: domain, code: code, userInfo: nil)
     
        if let nonfatal = CrashReporting.error(error) {
            
            //Custom fingerprinting
            nonfatal.groupingString = self.groupingString
            
            //Select Level
            switch errorLevel {
            case .critical:     nonfatal.level = .critical
            case .warning:      nonfatal.level = .warning
            case .error:        nonfatal.level = .error
            case .information:  nonfatal.level = .info
            }
            
            //select stacktrace mode
            switch stackTraceMode {
            case .full:         nonfatal.stackTraceMode = .full
            case .callerThread: nonfatal.stackTraceMode = .callerThread
            }
            
            
            nonfatal.report()
        }
        
    }

    // Fatal Crash
    func triggerFatal() {
        fatalError("Luciq test fatal crash")
    }
    
    
    func applySettings(stackTraceMode mode: StackTraceMode, OOMState: Bool, fingerprintingEnabled: Bool, fingerprint: String, appHangsState: Bool, forceRestartsState: Bool) {
        
        if mode != self.stackTraceMode {
            applyStackTraceMode(mode: mode)
        }
        
        if(OOMState != self.isOOMEnabled){
            applyOOMState(state: OOMState)
        }
        
        if(appHangsState != self.isAppHangsEnabled){
            applyAppHangsState(state: appHangsState)
        }
        
        if(forceRestartsState != self.isForceRestartsEnabled){
            applyForceRestartsState(state: forceRestartsState)
        }
        
        if fingerprintingEnabled != isCustomFingerprintingEnabled || (fingerprintingEnabled && fingerprint != groupingString)
        {
            applyCustomFingerprinting(
                enabled: fingerprintingEnabled,
                fingerprint: fingerprint)
        }
    }
    
    
    //Apply Stack trace mode (full/ current thread)
    func applyStackTraceMode(mode: StackTraceMode) {
        self.stackTraceMode = mode
    }
    
    //Apply OOM State (enabled/ disabled)
    func applyOOMState(state: Bool){
        CrashReporting.oomEnabled = state
        self.isOOMEnabled = state
    }
    
    //Apply Custom fingerprinting (enabled/ disabled)
    func applyCustomFingerprinting(enabled: Bool, fingerprint: String) {
        self.isCustomFingerprintingEnabled = enabled
        self.groupingString = enabled
            ? fingerprint
            : "com.service.method.some_exception"
    }
    
    //Apply App hangs state (enabled/ disabled)
    func applyAppHangsState(state: Bool){
        CrashReporting.appHangEnabled = state
        self.isAppHangsEnabled = state
    }
    
    //Apply Force Restarts state (enabled/ disabled)
    func applyForceRestartsState(state: Bool){
        CrashReporting.forceRestartEnabled = state
        self.isForceRestartsEnabled = state
    }
    
   
}
