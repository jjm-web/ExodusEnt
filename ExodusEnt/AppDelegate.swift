//
//  AppDelegate.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/09/06.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   

//    // 메인 화면으로 이동하기
//    private func showMainViewController() {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let mainViewController = storyboard.instantiateViewController(withIdentifier: "AgreementViewController")
//        mainViewController.modalPresentationStyle = .fullScreen
//        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
//    }

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 0.6)
        
        KakaoSDK.initSDK(appKey: "f3d6de1a34db1935a2aeb71f5593c4a0")
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        
        // Override point for custsomization after application launch.
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 구글의 인증 프로세스가 끝날 때 앱이 수신하는 url 처리
        //return GIDSignIn.sharedInstance().handle(url)

                if AuthController.handleOpenUrl(url: url, options: options) {
                    return true
                }
            
                if GIDSignIn.sharedInstance.handle(url) {
                    // Handle other custom URL types.
                    return true
                }
        return false
    }
    
}
    
  



