//
//  MaxiPlayerView.swift
//  PomoFocus
//
//  Created by Davide Formisano on 11/12/23.
//

import SwiftUI
import AVKit

struct Song {
    let title: String
    let artist: String
    let imageName: String
    let audioFileName: String
}

struct MaxiPlayerView: View {
    
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @State private var currentSongIndex = 0
    @EnvironmentObject private var playerManager: MusicPlayerManager
    
    let songs: [Song] = [
            Song(title: "Good Times", artist: "Pippo", imageName: "TestImage", audioFileName: "homestuck"),
            Song(title: "Life is Good", artist: "Paperino", imageName: "TestImage2", audioFileName: "bensound-lostinthehaze"),
            Song(title: "Relaxing", artist: "Topolino", imageName: "TestImage3", audioFileName: "bensound-boundlessspace")
            
        ]
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
                VStack(spacing: 15){
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40, height: 5)
                        .padding()
                    
                    GeometryReader{
                        let size = $0.size
                        
                        Image(playerManager.songs[playerManager.currentSongIndex].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .accessibilityHidden(true)
                    }
                    .frame(height: size.width - 50)
                    .padding(.vertical, size.height < 700 ? 10 : 30)
                    
                    
                    PlayerView(size)
                        
                     
                    
                }
                
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            
        }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            playerManager.updateProgress()
        }
        
        .preferredColorScheme(.dark)
        
    }

    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader{
            
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing){
                VStack(spacing: spacing){
                    HStack(alignment: .center, spacing: 15){
                        VStack(alignment: .leading, spacing: 4){
                            Text(playerManager.songs[playerManager.currentSongIndex].title)
                                .font(.title3)
                            .fontWeight(.semibold)
                            
                            Text(playerManager.songs[playerManager.currentSongIndex].artist)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button{
                            
                        }label: {
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
                    
                    Slider(value: Binding(get: {
                        playerManager.currentTime
                   }, set: { newValue in
                       playerManager.seekAudio(to: newValue)
                   }), in: 0...playerManager.totalTime)
                   .accentColor(.redd)
                    
                    HStack{
                        Text(playerManager.timeString(time: playerManager.currentTime))
                            Spacer()
                        Text(playerManager.timeString(time: playerManager.totalTime))
                    }
                }
                
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.width * 0.18){
                    Button{
                        playerManager.playPreviousSong()
                    }label: {
                        
                        Image(systemName: "backward.fill")
                            .font(.system(size: 25))
                            .accessibilityLabel("Previous song")
                            //.font(size.height < 300 ? .title3 : .title)
                    }
                    
                    Button{
                        
                    }label: {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 45))
                            .accessibilityLabel("Play song")
                            //.font(size.height < 300 ? .largeTitle : .system(size: 50))
                            .onTapGesture {
                                playerManager.isPlaying ? playerManager.stopAudio() : playerManager.playAudio()
                            }
                    }
                    
                    Button{
                        playerManager.playNextSong()
                    }label: {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 25))
                            .accessibilityLabel("Next song")
                            //.font(size.height < 300 ? .title3 : .title)
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    */
                    
                }
               
                 
            }
        }
}
    


