//
//  ContentView.swift
//  PomoFocusdef
//
//  Created by Rodolfo Falanga on 06/12/23.
//

import SwiftUI
import AVFoundation

struct AppBtn: ViewModifier {
    
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
    func appBtn(color: Color = .red) -> some View {
        modifier(AppBtn(color: color))
    }
}



struct ContentView: View {
    
    @State var appState = AppState {
        AudioServicesPlaySystemSound(1032)
    }
    
    @State var timer: Timer? = nil
    
    @State private var isModal:  Bool = false
    
    
    var body: some View {
       
            ZStack {
                VStack(spacing: 10) {
                    
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
                   
                        Stepper("\(appState.workMinutes) minute session", value: $appState.workMinutes, in: 1...99)
                            .disabled(timer != nil)
                            .padding()
                            .background(.redd)
                            .foregroundColor(.black)
                            .font(.title)
                            .cornerRadius(15.0)

                    Stepper("\(appState.restMinutes) minute break ", value: $appState.restMinutes, in: 1...99)
                            .disabled(timer != nil)
                            .padding()
                            .background(.redd)
                            .foregroundColor(.black)
                            .font(.title)
                            .cornerRadius(15.0)
                    HStack {
                        VStack{
                            
                            Button(action: {
                                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                                    appState.next()
                                    isModal.toggle()
                                }
                            }) {
                                
                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(.redd)
                                    .font(.system(size: 60))
                            }.padding(60)
                        }
                        
                        /*
                        Button(action: {
                            timer?.invalidate()
                            timer = nil
                        }) {
                            Image(systemName: "stop.circle.fill")
                                .font(.system(size: 35))
                        }.padding(20)
                        */
                        /*
                        Button(action: {
                            timer?.invalidate()
                            timer = nil
                            appState.reset()
                        }) {
                            Image(systemName: "gobackward")
                                .font(.system(size: 35))
                        }.padding(20)
                         */
                    }
                    Spacer()
                }
                .foregroundColor(.black)
                .padding()
            }
            .background(.bgTab)
            .edgesIgnoringSafeArea(.all)
       
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

