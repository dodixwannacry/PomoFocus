//
//  TabBar.swift
//  PomoFocus
//
//  Created by Davide Formisano on 07/12/23.
//

import SwiftUI

struct TabBar: View {
    
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    @State var index = 0
    
    var body: some View {
        
            TabView(selection: $index)
            {
                ContentView()
                    .tabItem { Image(systemName: "timer");Text("Timer");
                        
                    }
                    .tag(0)
                LibraryView()
                    .tabItem { Image(systemName: "home.fill");Text("Library");
                        
                    }
                    .tag(0)
            }
            .safeAreaInset(edge: .bottom) {
                CustomButtonSheet()
            }
            .overlay{
                if expandSheet {
                    ExpadendBottomSheet(expandSheet: $expandSheet, animation: animation)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
                }
            }
        
    }
    
    @ViewBuilder
    func CustomButtonSheet() -> some View{
        ZStack{
            Rectangle()
                .fill(.ultraThickMaterial)
                .overlay{
                    MusicInfo(expandSheet: $expandSheet, animation: animation)
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
    var animation: Namespace.ID
    var body: some View {
        HStack(spacing: 0){
            ZStack{
                if !expandSheet {
                    GeometryReader{
                        let size = $0.size
                        
                        Image("TestImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "TestImage", in: animation)
                }
            }
            .frame(width: 45, height: 45)
            
            Text("GOOD TIMES")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            }
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding(.leading, 25)
        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}
