//
//  HomeController.swift
//  EightHomeWork
//
//  Created by Александр Меренков on 13.10.2022.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
//    MARK: - Properties
    
    var timer: Timer?
    var timeInterval = 0
    var isTimerWorked = false
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationStart = NotificationCenter.default
        notificationStart.addObserver(self, selector: #selector(continueTimer), name: UIApplication.didBecomeActiveNotification, object: nil)
        let notificationStop = NotificationCenter.default
        notificationStop.addObserver(self, selector: #selector(stopTimer), name: UIApplication.willResignActiveNotification, object: nil)
        
        stopButton.isEnabled = false
    }
    
//    MARK: - Helpers
    
    func startTimer() {
        if timer == nil {
            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            self.timer = timer
        }
    }
    
    func enableButton() {
        startButton.isEnabled = !startButton.isEnabled
        stopButton.isEnabled = !stopButton.isEnabled
    }
    
//    MARK: - Selectors
    
    @objc func continueTimer() {
        if isTimerWorked {
            startTimer()
        }
    }
    
    @objc func updateTimer() {
        timeInterval += 1
        let minute = timeInterval / 60
        let second = timeInterval % 60
        var stringMinute = String(minute)
        var stringSecond = String(second)
        if stringMinute.count == 1 {
            stringMinute = "0" + stringMinute
        }
        if stringSecond.count == 1 {
            stringSecond = "0" + stringSecond
        }
        timeLabel.text = stringMinute + ":" + stringSecond
    }
    
    @objc func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
//    MARK: - Actions
    
    @IBAction func handleStart(_ sender: UIButton) {
        startTimer()
        enableButton()
        isTimerWorked = true
    }
    
    @IBAction func handeStop(_ sender: UIButton) {
        stopTimer()
        enableButton()
        isTimerWorked = false
    }
}
