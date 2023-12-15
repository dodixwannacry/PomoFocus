//
//  PomoFocusdefApp.swift
//  PomoFocusdef
//
//  Created by Rodolfo Falanga on 06/12/23.
//

import SwiftUI
import UIKit
import UserNotifications
import AVFAudio

@main
struct PomoFocusdef: App {
    @State private var expandSheet: Bool = false
    @State var index = 0
    @State private var isModal:  Bool = false
    @State private var isTesting:  Bool = false
    var playerManager = MusicPlayerManager()
    
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
            .environmentObject(playerManager)
            
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
                        MusicInfo(expandSheet: $expandSheet).environmentObject(playerManager)
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
    @State private var currentSongIndex = 0
    @Binding var expandSheet: Bool
    @State private var isTesting: Bool = false
    @State private var isModal: Bool = false
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @EnvironmentObject private var playerManager: MusicPlayerManager
    
    let songs: [Song] = [
        Song(title: "Good Times", artist: "Pippo", imageName: "TestImage", audioFileName: "homestuck"),
        Song(title: "Life is Good", artist: "Paperino", imageName: "TestImage2", audioFileName: "bensound-lostinthehaze"),
        Song(title: "Relaxing", artist: "Topolino", imageName: "TestImage3", audioFileName: "bensound-boundlessspace")
    ]
    var body: some View {
        HStack(spacing: 0){
            ZStack{
                Button(action: {
                    isModal.toggle()
                }) {
                    HStack{
                        Image(playerManager.songs[currentSongIndex].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50  ,height: 50 )
                        
                        
                        Text(playerManager.songs[currentSongIndex].title)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .padding(.horizontal, 15)
                        
                        Spacer(minLength: 0)
                        
                        Button{
                            
                        }label: {
                            Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title2)
                                .onTapGesture {
                                    playerManager.isPlaying ? playerManager.stopAudio() : playerManager.playAudio()
                                }
                        }
                        Button {
                            playerManager.playNextSong()
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
    
//    private func setupAudio(){
//        guard let url = Bundle.main.url(forResource: songs[currentSongIndex].audioFileName, withExtension: "mp3")
//        else{
//            return
//        }
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.prepareToPlay()
//            totalTime = player?.duration ?? 0.0
//        }catch {
//            print("Errir loading audio: \(error)")
//        }
//    }
//    
//    private func playAudio(){
//        player?.play()
//        isPlaying = true
//    }
//    
//    private func stopAudio() {
//        player?.pause()
//        isPlaying = false
//    }
//    private func playNextSong() {
//        stopAudio()
//        currentSongIndex = (currentSongIndex + 1) % songs.count
//        setupAudio()
//        playAudio()
//    }
}

class MusicPlayerManager: ObservableObject {
    @Published var currentSongIndex = 0
    @Published var isPlaying = false
    @Published private var totalTime: TimeInterval = 0.0
    @Published var isTesting: Bool = false
    @Published private var currentTime: TimeInterval = 0.0
    
    let songs: [Song] = [
        Song(title: "Good Times", artist: "Pippo", imageName: "TestImage", audioFileName: "homestuck"),
        Song(title: "Life is Good", artist: "Paperino", imageName: "TestImage2", audioFileName: "bensound-lostinthehaze"),
        Song(title: "Relaxing", artist: "Topolino", imageName: "TestImage3", audioFileName: "bensound-boundlessspace")
    ]
    
    
    
    func playButt(){
        if isTesting {
            pauseMusic()
            isTesting = false
        } else {
            playMusic()
            resumeMusic()
            isTesting = true
        }
    }
    
    func setupAudio(){
          guard let url = Bundle.main.url(forResource: songs[currentSongIndex].audioFileName, withExtension: "mp3")
           else{
               return
           }
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                totalTime = player?.duration ?? 0.0
            }catch {
                print("Error loading audio: \(error)")
            }
        }
    
    func playAudio(){
            player?.play()
            isPlaying = true
        }
    
    func stopAudio() {
           player?.pause()
            isPlaying = false
        }
    
    func updateProgress() {
            guard let player = player else { return }
            currentTime = player.currentTime
        }
    
    func seekAudio(to time: TimeInterval) {
            player?.currentTime = time
        }
    
    func timeString(time: TimeInterval) -> String {
            let minute = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minute, seconds)
        }
    
    func playPreviousSong() {
                stopAudio()
                currentSongIndex = (currentSongIndex - 1 + songs.count) % songs.count
                setupAudio()
                playAudio()
           }
    
    func playNextSong() {
                stopAudio()
                currentSongIndex = (currentSongIndex + 1) % songs.count
                setupAudio()
                playAudio()
            }

}


