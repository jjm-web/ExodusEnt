//
//  LoginNavigationController.swift
//  
//
//  Created by mac on 2023/08/21.
//

import UIKit
import FirebaseAuth
import RealmSwift
import FirebaseDatabase
class LoginNavigationController: UINavigationController {

    let realm = try! Realm()
    let firebaseAuth = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("## realm file dir -> \(Realm.Configuration.defaultConfiguration.fileURL!)")
        if (firebaseAuth != nil) && (realm.isEmpty == false) {
            showMainScreen()
        } else {
            showLoginScreen()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          print("ViewController의 view가 Load됨")
    }

    
    func showMainScreen() {
        
        do {
            try Auth.auth().signOut()
            print("Logged out successfully.")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
        
        let tabView = UIStoryboard.init(name: "Main", bundle: nil)
            guard let mainView = tabView.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {return}
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainView, animated: false)
    }
    
    func showLoginScreen() {
     
        let user = firebaseAuth
        
        do {
            try Auth.auth().signOut()
            print("Logged out successfully.")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
        
        if let user = user {
            // Delete the user account
            user.delete { error in
                if let error = error {
                    print("Error deleting user account: \(error)")
                } else {
                    print("User account deleted successfully.")
                   
                }
            }
        } else {
            print("No user signed in.")
        }
     
        rootView()
        
        }


    }
    func rootView() {
        let tabbar = UIStoryboard.init(name: "Main", bundle: nil)
            guard let mainView = tabbar.instantiateViewController(withIdentifier: "LoginNavigationController") as? TabBarViewController else {return}
          (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainView, animated: false)

}
