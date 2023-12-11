//
//  File.swift
//  PomoFocus
//
//  Created by Davide Formisano on 09/12/23.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer!

func playMusic(key: String) {
    let soundURL = Bundle.main.url(forResource: key, withExtension: "mp3")
    
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
