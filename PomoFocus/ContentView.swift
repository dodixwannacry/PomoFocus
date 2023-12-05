//
//  ContentView.swift
//  PomoFocus
//
//  Created by Rodolfo Falanga on 05/12/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    var body: some View {
            Home()
                .environmentObject(pomodoroModel)
                
        }
}

#Preview {
    ContentView()
}
