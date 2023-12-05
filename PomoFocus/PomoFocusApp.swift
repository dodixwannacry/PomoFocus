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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
    }
}
