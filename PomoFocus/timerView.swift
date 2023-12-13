//
//  timerView.swift
//  PomoFocus
//
//  Created by Rodolfo Falanga on 13/12/23.
//

import SwiftUI
import AVFoundation

struct AppBtn1: ViewModifier {
    
    let color: Color

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(minWidth: 50, maxHeight: 50)
            .font(.title)
            .background(color)
    }
}

extension Button {
    func appBtn1(color: Color = .red) -> some View {
        modifier(AppBtn(color: color))
    }
}



struct timerView: View {
    
    @State var appState = AppState {
        AudioServicesPlaySystemSound(1032)
    }
    
    @State var timer: Timer? = nil
    
    @State private var isModal:  Bool = false
    @Environment (\.presentationMode) var presentationmode
    @State private var isStart: Bool  = false
    
  
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 10) {
                Spacer()
                GeometryReader { geo in
                    Spacer()
                    ZStack() {
                        Image("Tomato")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack{
                            Text(appState.mode.rawValue)
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                            Text(appState.currentTimeDisplay)
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                        }
                        
                    }.frame(width: geo.size.width, height: geo.size.height)
                }.frame(maxHeight: 350)
                
                
                HStack {
                    
                     Button(action: {
                         if isStart {
                             timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                                 appState.next()
                             }
                             isStart = false
                         } else {
                             timer?.invalidate()
                             timer = nil
                             isStart = true
                         }
                     }) {
                         Text(isStart ? "Resume" : "Pause")
                        .foregroundColor(.redd)
                        .font(.system(size: 35))
                     }.padding(20)
                     
                    
                     Button(action: {
                         presentationmode.wrappedValue.dismiss()
                     }) {
                     Text("Return")
                        .foregroundColor(.redd)
                        .font(.system(size: 35))
                     }.padding(20)
                     
                }
                Spacer()
            }
            .foregroundColor(.black)
            .padding()
        }
        .background(.bgTab)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            if isStart == false {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                    appState.next()
                }
            }
        }
        .onDisappear {
                    timer?.invalidate()
                    timer = nil
                }
    }
}

struct timerView_Previews: PreviewProvider {
    static var previews: some View {
        timerView()
            
    }
}



