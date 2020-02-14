//
//  AppDelegate.swift
//  MusalaWeatherApp
//
//  Created by zdravko zdravkin on 2/10/20.
//  Copyright © 2020 zdravko zdravkin. All rights reserved.
//

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            debugPrint("Documents Folder: \(documentsDirectory)")
        #endif
        
        #if DEV
        debugPrint("Application build from DEV Target")
        #elseif PROD
        debugPrint("Application build from PROD Target")
        #elseif TEST
        debugPrint("Application build from TEST Target")
        #elseif UA
        debugPrint("Application build from UA Target")
        #endif

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
