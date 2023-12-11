//
//  ExpadendBottomSheet.swift
//  PomoFocus
//
//  Created by Davide Formisano on 06/12/23.
//

import SwiftUI
import AVFoundation



struct ExpadendBottomSheet: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animateContent: Bool = false
    @State private var offsetY: CGFloat = 0
    @State private var isTesting: Bool = false
    var audioPlayerManager = AudioPlayerManager.shared
    var body: some View {
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack{
                
                RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous)
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(content: {
                        Rectangle()
                        RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius : 0, style: .continuous)
                            .fill(Color("BGColor"))
                            .opacity(animateContent ? 1 : 0)
                    })
                    .overlay{
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                            .allowsHitTesting(false)
                            .opacity(animateContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                VStack(spacing: 15){
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40, height: 5)
                        .opacity(animateContent ? 1 : 0)
                        .offset(y: animateContent ? 0 : size.height)
                    
                    GeometryReader{
                        let size = $0.size
                        
                        Image("TestImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: animateContent ? 15 : 5, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "TestImage", in: animation)
                    .frame(height: size.width - 50)
                    .padding (.vertical, size.height < 700 ? 10 : 30)
                    
                    
                    PlayerView(size)
                        .environmentObject(audioPlayerManager.viewModel)

                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translationY = value.translation.height
                        offsetY = (translationY > 0 ? translationY : 0)
                    }).onEnded({ value in
                        withAnimation(.easeInOut(duration: 0.00001)) {
                            if offsetY > size.height * 0.4 {
                                expandSheet = false
                                animateContent = false
                            } else {
                                offsetY = .zero
                            }
                        }
                    })
            )

            .ignoresSafeArea(.container ,edges: .all)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 0.35)){
                animateContent = true
            }
        }
    }
    @ViewBuilder
    func PlayerView(_ mainsize: CGSize) -> some View{
        
        GeometryReader{
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing){
                VStack(spacing: spacing){
                    HStack(alignment: .center, spacing: 15){
                        VStack(alignment: .leading, spacing: 4){
                            Text("GOOD TIMES")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Pippo")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .padding(12)
                                .background{
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                }
                        }
                    }
                    
                    sliderMusic()
                        
                        
            
                    HStack{
                        Text(timeString(from: player?.currentTime ?? 0))
                            .foregroundColor(.white)
                            .font(.caption)

                        Spacer()

                        Text(timeString(from: player?.duration ?? 0))
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 10)
                    
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.width * 0.18){
                    Button{
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    
                    Button{
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
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                    }
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                }
                .foregroundColor(.white)
                .frame(maxHeight: .infinity)
                
                VStack(spacing: spacing){
                    HStack(spacing: 15){
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.gray)
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(alignment: .top, spacing: size.width * 0.18) {
                        Button{
                            
                        } label: {
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                        }
                        
                        VStack(spacing: 6){
                            Button{
                                
                            } label: {
                                Image(systemName: "airpods.gen3")
                                    .font(.title2)
                            }
                            
                            Text("iJustine's Airpods")
                                .font(.caption)
                        }
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                        }
                    }
                    .foregroundColor(.white)
                    .blendMode(.overlay)
                    .padding(.top, spacing)
                }
                .frame(height: size.height / 2.5, alignment: .bottom)
            }
        }
    }
}

extension View{
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key)as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0
    }
}


