//
//  MusicView.swift
//  PomoFocus
//
//  Created by Rayehe Ashrafian on 13/12/23.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        @State  var selectedCircleIndex: Int? = nil
        ZStack{
            Color("BG")
              .ignoresSafeArea(.all)
            VStack{
                Image("Music")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .frame(width:300,height: 300)
                
                    .shadow(color:.red, radius: 0.5)
                Text("Music")
                
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
                
                Spacer()
                Button(action: {
                    ScheduleView()
                    
                    
                    selectedCircleIndex = 3 // Update this based on your logic
                }) {
                    HStack {
                        
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 16,height: 16)
                        
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 16,height: 16)
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 16,height: 16)
                        
                        
                    }
                }
                Spacer()
                    .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        }
        
        
    }
    
}

#Preview {
    MusicView()
}
