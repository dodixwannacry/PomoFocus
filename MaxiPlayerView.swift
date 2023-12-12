//
//  MaxiPlayerView.swift
//  PomoFocus
//
//  Created by Davide Formisano on 11/12/23.
//

import SwiftUI
import AVKit

struct MaxiPlayerView: View {
    
    
    
    @State private var player: AVAudioPlayer?
    
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    
    
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
                        
                        Image("TestImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
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
        
        
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
        
        .preferredColorScheme(.dark)
        
    }
    
    private func setupAudio(){
        guard let url = Bundle.main.url(forResource: "homestuck", withExtension: "mp3")
        else{
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        }catch {
            print("Errir loading audio: \(error)")
        }
    }
    
    private func playAudio(){
        player?.play()
        isPlaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
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
                            Text("GOOD TIMES")
                                .font(.title3)
                            .fontWeight(.semibold)
                            
                            Text("Pippo")
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
                       currentTime
                   }, set: { newValue in
                       seekAudio(to: newValue)
                   }), in: 0...totalTime)
                   .accentColor(.redd)
                    
                    HStack{
                        Text(timeString(time: currentTime))
                            Spacer()
                        Text(timeString(time: totalTime))
                    }
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.width * 0.18){
                    Button{
                        
                    }label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    
                    Button{
                        
                    }label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                            .onTapGesture {
                                isPlaying ? stopAudio() : playAudio()
                            }
                    }
                    
                    Button{
                        
                    }label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                }
                
                .frame(maxWidth: .infinity)
                
                VStack(spacing: spacing){
                    HStack(spacing: 15){
                        Image(systemName: "speaker.fill")
                            
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        Image(systemName: "speaker.wave.3.fill")
                    }
                    HStack(alignment: .top, spacing: size.width * 0.18){
                        Button{
                            
                        }label: {
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                            
                        }
                        
                        VStack(spacing: 6){
                            Button{
                                
                            }label: {
                                Image(systemName: "airpodspro.chargingcase.wireless.fill")
                                    .font(.title2)
                                
                        }
                            Text("Airpods")
                                .font(.caption)
                                
                          }
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                            
                        }
                        
                    }
                    
                }
                .frame(height: size.height / 2.5, alignment: .bottom)
            }
        }
    }
    
}




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
