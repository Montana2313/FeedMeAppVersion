//
//  AppDelegate.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 23.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let myconfig = ParseClientConfiguration { (ParseMutuableClientConfigration) in
            ParseMutuableClientConfigration.applicationId = "332932ae87b016300ce77883427116f37a907fc0"
            ParseMutuableClientConfigration.clientKey = "747b6a7553f357ef99046fc99c47ed34584621be"
            ParseMutuableClientConfigration.server = "http://18.219.17.4:80/parse"
        }
        rememberlogin()
        
        Parse.initialize(with: myconfig)
        
        let defacl = PFACL()
        defacl.getPublicReadAccess = true
        defacl.getPublicWriteAccess = true
        PFACL.setDefault(defacl, withAccessForCurrentUser: true)
        
       
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func rememberlogin()
    {
        let user : String? = UserDefaults.standard.string(forKey: "user")
        if user != nil
        {
            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbarcontroller  = board.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController
            window?.rootViewController = tabbarcontroller
            
            
        }
        
    }


}

