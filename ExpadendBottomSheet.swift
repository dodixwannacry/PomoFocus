//
//  ExpadendBottomSheet.swift
//  PomoFocus
//
//  Created by Davide Formisano on 06/12/23.
//

import SwiftUI
import AVFoundation



struct ExpadendBottomSheet: View {
    
    @State private var animateContent: Bool = false
    @State private var offsetY: CGFloat = 0
    @State private var isTesting: Bool = false
    @State private var isSearching: Bool = false
    @Environment (\.presentationMode) var presentationmode
    var body: some View {
        GeometryReader{
            let size = $0.size
            let spacing = size.height * 0.04
            
            
            VStack(spacing: spacing){
                VStack(spacing: 15){
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40, height: 5)
                        .padding()
                }
                Image("TestImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300  ,height: 300)
                    
                
                VStack(spacing: spacing){
                    HStack(alignment: .center, spacing: 15){
                        VStack(alignment: .leading, spacing: 4){
                            Text("GOOD TIMES")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Pippo")
                                
                        }
                        .padding()
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
                        .padding()
                    }
                    
                    sliderMusic()
                        
                        
            
                    HStack{
                        Text(timeString(from: player?.currentTime ?? 0))
                            .font(.caption)

                        Spacer()

                        Text(timeString(from: player?.duration ?? 0))
                            
                            .font(.caption)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 10)
                    
                }
                .padding()
                
                HStack(spacing: size.width * 0.18){
                    Button{
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(.title3)
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
                            .font(.largeTitle)
                    }
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(.title3)
                    }
                }
                .padding()
                
                
                /*
                VStack(spacing: spacing){
                    HStack(spacing: 15){
                        Image(systemName: "speaker.fill")
                            
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        
                        Image(systemName: "speaker.wave.3.fill")
                            
                    }
                    .padding()
                 */
                    
                    /*
                    HStack(spacing: spacing) {
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
                     */
                    
                }
            }
        }
}
         
    /*
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
     */





