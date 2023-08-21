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

        let tabbar = UIStoryboard.init(name: "Main", bundle: nil)
            guard let mainView = tabbar.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {return}
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainView, animated: false)
    }
    
    func showLoginScreen() {
     
        do {
            try Auth.auth().signOut()
            print("Logged out successfully.")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
        let user = Auth.auth().currentUser
        if let user = user {
            
            // Delete user data from Realtime Database (optional, if you're using Realtime Database)
            let ref = Database.database().reference()
            ref.child("ExodusEnt").child("UserAccount").child(user.uid).removeValue { error, _ in
                if let error = error {
                    print("Error deleting user data from Realtime Database: \(error)")
                } else {
                    print("User data deleted from Realtime Database successfully.")
                }
            }
            
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
    
        
        func rootView() {
            let tabbar = UIStoryboard.init(name: "Auth", bundle: nil)
                guard let mainView = tabbar.instantiateViewController(withIdentifier: "LoginNavigationController") as? TabBarViewController else {return}
                  (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainView, animated: false)
        }


    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
