//
//  PomodoroTimerModel.swift
//  PomoFocus
//
//  Created by Davide Formisano on 05/12/23.
//

import SwiftUI

class PomodoroModel: NSObject,ObservableObject, UNUserNotificationCenterDelegate{
    // MARK: Timer preparation
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    // MARK: Total Seconds
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    //MARK: Post Timer Properties
    @Published var isFinished: Bool = false
    
    // MARK: Since Its NSObject
    override init(){
        super.init()
        self.authorizeNotifications()
    }
    
    // MARK: Requesting NOtification Access
    func authorizeNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { _, _ in}
        
        // MARK: To Show In App Notifications
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.banner])
    }
    
    // MARK: Starting Timer
    func startTimer(){
        withAnimation(.easeInOut(duration: 0.25)){isStarted = true}
        // MARK: Setting String Time Value
        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)":"0\(minutes)"):\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
        // MARK: Calculating Total Seconds For Timer Animation
        totalSeconds = (hour * 3600) + (minutes * 60) + seconds
        staticTotalSeconds = totalSeconds
        addNewTimer = false
        addNotifications()
    }
    
    // MARK: Stopping Timer
    func stopTimer(){
        withAnimation{
            isStarted = false
            hour = 0
            minutes = 0
            seconds = 0
            progress = 1
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    
    // MARK: Updating Timer
    func updateTimer(){
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        // 60 minutes * 60 seconds
        hour = totalSeconds / 3600
        minutes = (totalSeconds / 60) % 60
        seconds = (totalSeconds % 60)
        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)":"0\(minutes)"):\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
        if hour == 0 && minutes == 0 && seconds == 0{
            isStarted = false
            print("Finished")
            isFinished = true
        }
    }
    
    func addNotifications(){
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Timer"
        content.subtitle = "Time is over"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(totalSeconds), repeats: false))
        
        UNUserNotificationCenter.current().add(request)
    }
}

