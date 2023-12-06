//
//  PomoFocusApp.swift
//  PomoFocus
//
//  Created by Rodolfo Falanga on 05/12/23.
//

import SwiftUI

@main
struct PomoFocusApp: App {
    // MARK: Since We're doing Background fetching Intializing Here
    @StateObject var pomodoroModel: PomodoroModel = .init()
    // MARK: Scene Phase
    @Environment (\.scenePhase) var phase
    // MARK: Storing Last Time Stamp
    @State var lastActiveTimeStamp: Date = Date()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
        .onChange(of: phase) { _, newPhase in
            if pomodoroModel.isStarted{
                if newPhase == .background {
                    lastActiveTimeStamp = Date()
                }
                
                if newPhase == .active {
                    // MARK: Finding The Difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if ((pomodoroModel.totalSeconds - Int(currentTimeStampDiff)) <= 0)  {
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.isFinished = true
                    }else{
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                    
                }
            }
        }
    }
}
