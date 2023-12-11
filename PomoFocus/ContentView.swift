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
    
    
    var body: some View {
       
            ZStack {
                LinearGradient(colors: [.white, .white], startPoint: .center, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(spacing: 10) {
                    Spacer()
                    GeometryReader { geo in
                        VStack(spacing: 10) {
                            Text(appState.mode.rawValue)
                                .foregroundColor(.black)
                                .font(.system(size: 50))
                            Text(appState.currentTimeDisplay)
                                .foregroundColor(.black)
                                .font(.system(size: 50))
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(.white)
                        .border(Color.black, width: 7)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }.frame(maxHeight: 150)
                    Spacer()
                        Stepper("\(appState.workMinutes)  minute session", value: $appState.workMinutes, in: 1...99)
                            .disabled(timer != nil)
                            .padding()
                            .background(.white)
                            .foregroundColor(.black)
                            .font(.title)
                            .cornerRadius(15.0)

                    Stepper("\(appState.restMinutes) minute break ", value: $appState.restMinutes, in: 1...99)
                            .disabled(timer != nil)
                            .padding()
                            .background(.white)
                            .foregroundColor(.black)
                            .font(.title)
                            .cornerRadius(15.0)
                    HStack {
                        Button(action: {
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                                appState.next()
                            }
                        }) {
                            
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 35))
                        }.padding(20)

                        Button(action: {
                            timer?.invalidate()
                            timer = nil
                        }) {
                            Image(systemName: "stop.circle.fill")
                                .font(.system(size: 35))
                        }.padding(20)


                        Button(action: {
                            timer?.invalidate()
                            timer = nil
                            appState.reset()
                        }) {
                            Image(systemName: "gobackward")
                                .font(.system(size: 35))
                        }.padding(20)
                    }
                    Spacer()
                }
                .foregroundColor(.black)
                .padding()
            }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

