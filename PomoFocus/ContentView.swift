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
                LinearGradient(colors: [.black, .purple], startPoint: .center, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(spacing: 10) {
                    Spacer()
                    GeometryReader { geo in
                        VStack(spacing: 10) {
                            Text(appState.mode.rawValue)
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                            Text(appState.currentTimeDisplay)
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        
                    }.frame(maxHeight: 150)
                        Stepper("\(appState.workMinutes)  minute session", value: $appState.workMinutes, in: 1...99)
                            .disabled(timer != nil)
                            .padding()
                            .background(.purple)
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(15.0)

                    Stepper("\(appState.restMinutes) minute break ", value: $appState.restMinutes, in: 1...99)
                            .disabled(timer != nil)
                            .padding()
                            .background(.purple)
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(15.0)
                    HStack {
                        Button("Start") {
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                                appState.next()
                            }
                        }.appBtn(color: .green)
                        Button("Stop") {
                            timer?.invalidate()
                            timer = nil
                        }.appBtn(color: .red)
                        Button("Reset") {
                            timer?.invalidate()
                            timer = nil
                            appState.reset()
                        }.appBtn(color: .yellow)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .padding()
            }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

