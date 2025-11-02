//
//  ProductsNavigationView.swift
//  IntsabugIOSSwift
//
//  Created by Mohamed Gazya on 22/07/2025.
//

import SwiftUI

struct ProductsNavigationView: View {
    
    @StateObject var APMcontroller = APMController()
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 0){
                
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: SDKSettings()){
                        
                        Text("SDK Settings")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 20))
                            .foregroundColor(Color("TextGray"))
                            .padding()
                            .background(Color("SecondaryColor"))
                            .cornerRadius(25)
                            .padding()
                            .contentShape(Rectangle())
                    }
                }
                HStack (spacing: 12){
                    NavigationLink(destination: BugReportingView()){
                        
                        Text("Bug Reporting")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 19))
                            .foregroundColor(Color("TextGray"))
                            .padding()
                            .frame(maxWidth:.infinity, minHeight:40)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(25)
                            .padding(.vertical)
                            .padding(.horizontal,10)
                            
                    }
                    NavigationLink(destination: CrashReportingView()){
                        
                        Text("Crash Reporting")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 19))
                            .foregroundColor(Color("TextGray"))
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(25)
                            .padding(.vertical)
                            .padding(.horizontal,10)
                            
                    }
                }
                HStack (spacing: 12){
                    NavigationLink(destination: APMView(controller: APMcontroller)){
                        
                        Text("APM")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 19))
                            .foregroundColor(Color("TextGray"))
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(25)
                            .padding(.vertical)
                            .padding(.horizontal,10)
                            
                    }
                    NavigationLink(destination: SurveysView()){
                        
                        Text("Surveys")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 19))
                            .foregroundColor(Color("TextGray"))
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(25)
                            .padding(.vertical)
                            .padding(.horizontal,10)
                            
                    }
                }
                HStack (spacing: 12) {
                    NavigationLink(destination: SessionReplayView()){
                        
                        Text("Session Replay")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 19))
                            .foregroundColor(Color("TextGray"))
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(25)
                            .padding(.vertical)
                            .padding(.horizontal,10)
                            
                    }
                    NavigationLink(destination: FeatureRequestsView()){
                        
                        Text("Feature Requests")
                            .font(Font.custom("ABCArizonaFlare-Medium", size: 19))
                            .foregroundColor(Color("TextGray"))
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(25)
                            .padding(.vertical)
                            .padding(.horizontal,10)
                            
                    }
                }
                Spacer()
                Spacer()
                
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
    }
}

#Preview {
    ProductsNavigationView()
}
