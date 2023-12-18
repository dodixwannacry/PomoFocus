//
//  TimerView.swift
//  PomoFocus
//
//  Created by Rayehe Ashrafian on 13/12/23.
//

import SwiftUI

struct TimerOnboardingView: View {
    var body: some View {
        
        @State  var selectedCircleIndex: Int? = nil
        
        
        
        ZStack {
            Color("BG")
              .ignoresSafeArea(.all)
            VStack {
                Image("Timer")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                
                    .shadow(color:.red, radius: 0.5)
                
                VStack{
                    Text("Timer")
                    
                        .font(.system(size: 32))
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                
                
                
                Text("A well organised timer helps you to schedule your tasks more efficiently.")
                
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom,50)
                
                Button(action: {
                    
                    
                    
                    selectedCircleIndex = 1 // Update this based on your logic
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(selectedCircleIndex == 0 ? .red : .red)
                            .frame(width: 16, height: 16)
                        Circle()
                            .foregroundColor(selectedCircleIndex == 1 ? .red : .white)
                            .frame(width: 16, height: 16)
                        
                        Circle()
                            .foregroundColor(selectedCircleIndex == 2 ? .red : .white)
                            .frame(width: 16, height: 16)
                    }
                    
                }
                
                
                .padding(.bottom, 50)
                
                Spacer()
                
            }
            Spacer()
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    //.background(Color("BGColor"))
    
}

#Preview {
    TimerOnboardingView()
}
