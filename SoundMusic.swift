//
//  SoundMusic.swift
//  PomoFocus
//
//  Created by Davide Formisano on 09/12/23.
//

import Foundation
import AVFoundation
import SwiftUI


var player: AVAudioPlayer!

func playMusic() {
    let soundURL = Bundle.main.url(forResource: "homestuck", withExtension: "mp3")
    
    guard soundURL != nil else{
        return
    }
    
    do {
        player = try AVAudioPlayer(contentsOf: soundURL!)
        player?.play()
    } catch {
        print("\(error)")
    }
}


func pauseMusic() {
    if let audioPlayer = player {
        if audioPlayer.isPlaying {
            let currentTime = audioPlayer.currentTime
                       UserDefaults.standard.set(currentTime, forKey: "currentAudioTime")
            audioPlayer.pause()
        }
    }
}

func resumeMusic() {
    if let audioPlayer = player,
       let savedTime = UserDefaults.standard.value(forKey: "currentAudioTime") as? TimeInterval {
        // Imposta la posizione corrente e riprendi la riproduzione
        audioPlayer.currentTime = savedTime
        audioPlayer.play()
    }
}



func sliderMusic() -> some View{
    Slider(value: Binding(get: {
        // Ottieni la posizione attuale della riproduzione
        if let player = player {
            return Double(player.currentTime)
        }
        return 0
    }, set: { newValue in
        // Imposta la posizione della riproduzione quando lo slider viene spostato
        if let player = player {
            player.currentTime = newValue
        }
    }), in: 0...(player?.duration ?? 0))
    
}


 func timeString(from time: TimeInterval) -> String {
 let minutes = Int(time) / 60
 let seconds = Int(time) % 60
 return String(format: "%02d:%02d", minutes, seconds)
 }

class AudioPlayerViewModel: ObservableObject {
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var isPlaying: Bool = false
    @Published var sliderValue: Double = 0

    func updateCurrentTime() {
        currentTime = player.currentTime
    }

    func updateDuration() {
        duration = player.duration
    }
}

class AudioPlayerManager: ObservableObject {
    static let shared = AudioPlayerManager()

    @Published var viewModel = AudioPlayerViewModel()

    func play() {
        // Logica per iniziare la riproduzione
        if let player = player {
            player.play()
            viewModel.isPlaying = true
        }
    }

    func pause() {
        // Logica per mettere in pausa la riproduzione
        if let player = player {
            player.pause()
            viewModel.isPlaying = false
        }
    }

    func resume() {
        // Logica per riprendere la riproduzione
        if let player = player {
            player.play()
            viewModel.isPlaying = true
        }
    }
}
