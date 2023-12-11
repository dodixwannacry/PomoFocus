//
//  TabBar.swift
//  PomoFocus
//
//  Created by Davide Formisano on 06/12/23.
//

import SwiftUI

struct TabBar: View {
    // Selected Tab Index...
    // Default is third...
    @State var current = 2
    
    var body: some View {
        
        // Bottom mini player...
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
            TabView(selection: $current){
                Text("Timer")
                    .tag(0)
                    .tabItem {
                        
                        Image(systemName: "timer")
                        
                        Text("Timer")
                    }
                
                Text("Library")
                    .tag(1)
                    .tabItem {
                        
                        Image(systemName: "rectangle.stack.fill")
                        
                        Text("Library")
                    }
            }
            
            BlurView()
                .frame(height: 80)
            // moving the miniplayer  above the tabbar...
            // approz tab bar height is 49
                .offset(y: -48)
        })
    }
}

