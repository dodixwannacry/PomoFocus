//
//  PomodoroTimerModel.swift
//  PomoFocus
//
//  Created by Davide Formisano on 05/12/23.
//

import SwiftUI

class PomodoroModel: NSObject,ObservableObject{
    // MARK: Timer preparation
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
}


