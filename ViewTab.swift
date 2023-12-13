//
//  TabView.swift
//  PomoFocus
//
//  Created by Davide Formisano on 12/12/23.
//

import SwiftUI

struct TabView: View {
    @State private var expandSheet: Bool = false
    @State var index = 0
    @State private var isModal:  Bool = false
    @State private var isTesting:  Bool = false
    var body: some View {
        
        TabView(selection: $index)
        {
            ContentView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }
                .tag(0)
            LibraryView()
                .tabItem {
                    Image(systemName: "square.stack.fill")
                    Text("Library")
                }
                .tag(1)
        }
        
        .toolbarBackground(.indigo, for: .tabBar)
        .toolbarBackground(.visible, for: . tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
        /*
         .onAppear(){
         UITabBar.appearance().backgroundColor = .tab
         }
         */
        
        .safeAreaInset(edge: .bottom) {
            CustomButtonSheet()
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

#Preview {
    TabView()
}
