//
//  PomoFocusdefApp.swift
//  PomoFocusdef
//
//  Created by Rodolfo Falanga on 06/12/23.
//

import SwiftUI

@main
struct PomoFocusdef: App {
    @State private var expandSheet: Bool = false
    @State var index = 0
    @State private var isModal:  Bool = false
    var body: some Scene {
        WindowGroup{
            
            
            TabView(selection: $index)
            {
                ContentView()
                    .tabItem { Image(systemName: "timer");Text("Timer");
                    }
                    .tag(0)
                LibraryView()
                    .tabItem { Image(systemName: "square.stack.fill");Text("Library");
                    }
                    .tag(0)
            }
            .accentColor(.redd)
            .toolbarBackground(.visible, for: .tabBar)
            .onAppear(){
                UITabBar.appearance().backgroundColor = .BG
            }
            .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
            .safeAreaInset(edge: .bottom) {
                CustomButtonSheet()
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
        }
    }


    
    
