import Foundation
import UserNotifications
import UIKit

enum Mode: String, Equatable {
    case rest = "Rest"
    case session = "Focus"
}

class BackgroundTaskManager {
    static let shared = BackgroundTaskManager()

    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    func startBackgroundTask(completion: @escaping () -> Void) {
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            completion()
            self.endBackgroundTask()
        }
    }

    private func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}

struct AppState {
    var workMinutes: Int = 25 {
        didSet {
            if mode == .session {
                currentTime = workMinutes * 60
            }
        }
    }

    var restMinutes: Int = 5 {
        didSet {
            if mode == .rest {
                currentTime = restMinutes * 60
            }
        }
    }

    var mode = Mode.session

    var currentTime: Int

    var playSound: () -> Void

    var backgroundTaskManager = BackgroundTaskManager.shared

    init(playSound: @escaping () -> Void) {
        self.currentTime = workMinutes * 60
        self.playSound = playSound
    }

    var currentTimeDisplay: String {
        let minutes = currentTime / 60
        let secondsLeft = currentTime % 60
        return "\(minutes):\(secondsLeft < 10 ? "0" : "")\(secondsLeft)"
    }

    mutating func next() {
        if currentTime > 0 {
            currentTime -= 1
            return
        }

        if currentTime == 0 {
            playSound()
            sendNotification()
        }

        switch mode {
        case .session:
            currentTime = self.restMinutes * 60
            mode = .rest
        case .rest:
            currentTime = self.workMinutes * 60
            mode = .session
        }
    }

    mutating func reset() {
        restMinutes = 5
        workMinutes = 25
        mode = .session
    }

    private func sendNotification() {
        backgroundTaskManager.startBackgroundTask {
            let content = UNMutableNotificationContent()
            content.title = "Timer Completed"
            content.body = "Your timer has reached zero."

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "timerNotification", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error sending notification: \(error.localizedDescription)")
                }
            }
        }
    }
}

