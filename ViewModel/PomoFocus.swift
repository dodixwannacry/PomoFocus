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
        requestNotificationAuthorization()
    }
    
    var body: some Scene {
        WindowGroup{
            
            ContentView()
                    CustomButtonSheet()
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
                    .background(.bgTab)
            }else {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay{
                        MusicInfo(expandSheet: $expandSheet).environmentObject(playerManager)
                    }
                
            }
            
        }
        .frame(height: 50)
        
    }
}



struct MusicInfo: View {
    @Binding var expandSheet: Bool
    @State private var isTesting: Bool = false
    @State private var isModal: Bool = false
    @State private var totalTime: TimeInterval = 0.0
    @EnvironmentObject private var playerManager: MusicPlayerManager
    
    var body: some View {
        HStack(spacing: 0){
            ZStack{
                Button(action: {
                    isModal.toggle()
                }) {
                    HStack{
                        Image(playerManager.songs[playerManager.currentSongIndex].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50  ,height: 50 )
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        
                        
                        Text(playerManager.songs[playerManager.currentSongIndex].title)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .padding(.horizontal, 15)
                        
                        Spacer(minLength: 0)
                        
                        Button{
                            
                        }label: {
                            Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title2)
                                .accessibilityLabel("Play song")
                                .onTapGesture {
                                    playerManager.isPlaying ? playerManager.stopAudio() : playerManager.playAudio()
                                }
                        }
                        Button {
                            playerManager.playNextSong()
                        } label: {
                            Image(systemName: "forward.fill")
                                .font(.title2)
                                .accessibilityLabel("Next song")
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

class MusicPlayerManager: ObservableObject {
    @Published var currentSongIndex = 0
    @Published var isPlaying = false
    @Published var totalTime: TimeInterval = 0.0
    @Published var isTesting: Bool = false
    @Published var currentTime: TimeInterval = 0.0
    
    @Published var songs: [Song] = [
        Song(title: "Homestcuk", artist: "Waverly", imageName: "TestImage", audioFileName: "homestuck"),
        Song(title: "Boundless Space", artist: "DPMusic", imageName: "TestImage2", audioFileName: "bensound-lostinthehaze"),
        Song(title: "Lost In The Haze", artist: "Veace D", imageName: "TestImage3", audioFileName: "bensound-boundlessspace"),
        Song(title: "The Calling", artist: "Risian", imageName: "TestImage4", audioFileName: "bensound-thecalling"),
        Song(title: "Immense Void", artist: "DPMusic", imageName: "TestImage5", audioFileName: "bensound-immensevoid")
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
    
    init() {
        setupAudio()
    }
    
    func setupAudio(){
        do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Errore durante la configurazione dell'audio session: \(error.localizedDescription)")
            }
        
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


