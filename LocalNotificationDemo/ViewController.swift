//
//  ViewController.swift
//  LocalNotificationDemo
//
//  Created by Rupali Patil on 12/07/19.
//  Copyright © 2019 Kanishka Consultancy. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (granted, error) in
            if granted {
                print("yes")
            }else{
                print("no")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
    }

    private func configureUserNotificationsCenter() {
        // Configure User Notification Center
        UNUserNotificationCenter.current().delegate = self
        
        // Define Actions
        let actionReadLater = UNNotificationAction(identifier: Notification.Action.readLater, title: "Read Later", options: [])
        let actionShowDetails = UNNotificationAction(identifier: Notification.Action.showDetails, title: "Show Details", options: [.foreground])
        let actionUnsubscribe = UNNotificationAction(identifier: Notification.Action.unsubscribe, title: "Unsubscribe", options: [.destructive, .authenticationRequired])
        
        // Define Category
        let tutorialCategory = UNNotificationCategory(identifier: Notification.Category.tutorial, actions: [actionReadLater, actionShowDetails, actionUnsubscribe], intentIdentifiers: [], options: [])
        
        // Register Category
        UNUserNotificationCenter.current().setNotificationCategories([tutorialCategory])
    }
    
    
    @IBAction func btnSend_onClick(_ sender: Any)
    {
         let content = UNMutableNotificationContent()
        content.title = "Kanishka Software"
        content.subtitle = "kspl.com"
        content.body = "Test local notification on simulator"
        
//        let imageName = "bell"
//        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
//
//        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
//
//        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        // 4
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }
}

