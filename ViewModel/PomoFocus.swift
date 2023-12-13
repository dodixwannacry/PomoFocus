//
//  PomoFocusdefApp.swift
//  PomoFocusdef
//
//  Created by Rodolfo Falanga on 06/12/23.
//

import SwiftUI
import UIKit
import UserNotifications

@main
struct PomoFocusdef: App {
    @State private var expandSheet: Bool = false
    @State var index = 0
    @State private var isModal:  Bool = false
    @State private var isTesting:  Bool = false
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var body: some Scene {
        WindowGroup{
            
            
            TabView(selection: $index)
            {
                ContentView()
                    .onAppear {
                                        requestNotificationAuthorization()
                                    }
                    .tabItem {
                        Image(systemName: "timer")
                            .renderingMode(.original)
                        Text("Timer")
                            
                            
                    }
                    
                    .tag(0)
                LibraryView()
                    .tabItem { 
                        Image(systemName: "square.stack.fill")
                            .renderingMode(.original)
                        Text("Library")
                            
                            
                    }
                    
                    .tag(1)
            }
            .tint(.redd)
            
            .onAppear(){
                UITabBar.appearance().backgroundColor = .tab
                    
            }
             
            
            .safeAreaInset(edge: .bottom) {
                CustomButtonSheet()
                 }
            
                        
        }
      
        
        
    }
    
    private func requestNotificationAuthorization() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    print("L'utente ha autorizzato le notifiche")
                } else if let error = error {
                    print("Errore nella richiesta di autorizzazione: \(error.localizedDescription)")
                }
            }
        }
    
    @ViewBuilder
    func CustomButtonSheet() -> some View{
        ZStack{
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            }else {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay{
                        MusicInfo(expandSheet: $expandSheet)
                    }
                    
            }
            
        }
        .frame(height: 70)
        .overlay(alignment: .bottom, content: {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
                
        })
        .offset(y: -49)
    }
     
}


struct MusicInfo: View {
    @Binding var expandSheet: Bool
    @State private var isTesting: Bool = false
    @State private var isModal: Bool = false
    var body: some View {
        HStack(spacing: 0){
            ZStack{
                        Button(action: {
                            isModal.toggle()
                        }) {
                            HStack{
                                Image("TestImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50  ,height: 50 )
                                
                                
                                Text("GOOD TIMES")
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .padding(.horizontal, 15)
                                
                                Spacer(minLength: 0)
                                
                                Button {
                                    if isTesting {
                                        pauseMusic()
                                        isTesting = false
                                    } else {
                                        playMusic()
                                        resumeMusic()
                                        isTesting = true
                                    }
                                } label: {
                                    Image(systemName: isTesting ? "pause.fill" : "play.fill")
                                        .font(.title2)
                                }
                                Button {
                                    
                                } label: {
                                    Image(systemName: "forward.fill")
                                        .font(.title2)
                                }
                                .padding(.leading, 25)
                                
                            }
                        }
                        .sheet(isPresented: $isModal) {
                            MaxiPlayerView()
                        }
            }
            .foregroundColor(.primary)
            .padding(.horizontal)
            .padding(.bottom, 5)
            .frame(height: 70)
            .contentShape(Rectangle())
            }
        .background(.redd)
        .edgesIgnoringSafeArea(.all)
        }
    }


    
    
