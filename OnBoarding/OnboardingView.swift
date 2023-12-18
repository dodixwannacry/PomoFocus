//
//  ContentView.swift
//  PomoFocus
//
//  Created by Rayehe Ashrafian on 12/12/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("PomoFocusApp") private var isPomoFocusApp: Bool = true
    private var previewIsPomoFocusApp: Bool = true
    @State private var currentPage = 0
    private let numberOfPages = 4
    

    
    var body: some View {
        NavigationStack {
            if  isPomoFocusApp {
                ZStack {
                    Color("BG")
                        .edgesIgnoringSafeArea(.all)
                        
                    VStack {
                        Image("Icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:500,height: 500)
                            .shadow(color:.red, radius: 0.5)
                            .padding(.bottom, -190)
                        
                        
                        Text("Welcome to Pomo Focus")
                            .frame(width: 200, height:200)
                            .font(.system(size: 32))
                            .bold()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, -100)
                        
                        
                        
                        
                        
                        Text("Pomodoro helps you focus on time, plan tasks and take notes.")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom,20)
                            .frame(width: 350.0, height: 200.0)
                        
                        
                        VStack{
                            
                            NavigationLink(destination: TimerOnboardingView()) {
                                Text("Next")
                                    .frame(width: 156, height: 40)
                                    .font(.system(size: 25))
                                    .bold()
                                    .foregroundColor(.white)
                                
                                
                                    .background(Color.red) // Set the background color here
                                    .frame(width: 156, height: 40)
                                    .cornerRadius(30)
                                    .shadow(color: .red, radius: 2.0)
                                    .padding(.bottom,150)
                                
                            }
                            
                        }
                        
                    }
                    .tag(0)
                }
            } else {
                Text("false")
            }
            
            
            
        }
    }
    
}


#Preview {
    OnboardingView()
}
