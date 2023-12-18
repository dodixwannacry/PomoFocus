//
//  ScheduleView.swift
//  PomoFocus
//
//  Created by Rayehe Ashrafian on 15/12/23.
//

import SwiftUI

struct ScheduleView: View {
    @State  var selectedCircleIndex: Int? = nil
    var body: some View {
        ZStack{
            Color("BG")
                .ignoresSafeArea(.all)
            VStack{
                Image("Schedule")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300,height: 300)
                    .shadow(color:.red, radius: 0.5)
                    
                Text("Schedule")
                
                    .font(.system(size: 32))
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
               
                Text("A well organised timer helps you to schedule your tasks more efficiently.")
                
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom,50)
                
                HStack {
                    
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 16,height: 16)
                    
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 16,height: 16)
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 16,height: 16)
                    
                    
                }
                
                Spacer()
                    .padding()
                
                HStack{
                    Text("Got it!")
                        .frame(width: 156, height: 40)
                        .font(.system(size: 25))
                        .bold()
                        .foregroundColor(.white)
                    
                    
                        .background(Color.red) // Set the background color here
                        .frame(width: 156, height: 40)
                        .cornerRadius(30)
                        .shadow(color: .red, radius: 2.0)
                        .padding(.leading,165)
                }
               Spacer()
                
            }
            
        }
       
    }
}

#Preview {
    ScheduleView()
}
