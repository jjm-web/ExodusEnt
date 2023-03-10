//
//  PrivacyViewController.swift
//  ExodusEnt
//
//  Created by mac on 2022/12/26.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PrivacyViewController: UIViewController {
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblNickName: UILabel!
    @IBOutlet weak var lblmyiDol: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    
    @IBOutlet weak var lblTotalHeart: UILabel!
    @IBOutlet weak var lblEver: UILabel!
    @IBOutlet weak var lblDaily: UILabel!
    @IBOutlet weak var lblDia: UILabel!
    
    @IBOutlet weak var heartProgress: UIProgressView!
    
    @IBOutlet weak var btnUserDelete: UIButton!
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        userPryvacy()
        
        btnUserDelete.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func userPryvacy() {

        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("name").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblNickName.text = value
            }
        }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("bestIdol").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblmyiDol.text = value
            }
        }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("level").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblLevel.text = "Lv.\(value)"
            }
        }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("heart").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblTotalHeart.text = value
            }
        }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("diamond").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblDia.text = value
            }
        }) { error in
            print(error.localizedDescription)
        }
        
    }

    @objc func btnAction() {

        let alert = UIAlertController(title: "????????? ?????? ???????????????????", message: "????????? ???????????? ?????? ???????????? ???????????????.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "??????", style: .default, handler: self.delete)
        let cancle = UIAlertAction(title: "??????", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancle)
        self.present(alert, animated: false, completion: nil)

}
    
    func btnReAction() {

        let alert = UIAlertController(title: "????????? ?????? ????????????.", message: "????????? ??????????????????.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "??????", style: .default, handler: self.rootView)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
}
    
    
    func delete(alert: UIAlertAction!) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if error != nil {
            // An error happened.
          } else {
            // Account deleted.
          }
            self.btnReAction()
        }
    }

    
    func rootView(alert: UIAlertAction!) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
          }
        self.ref.child("ExodusEnt").child("UserAccount").child(self.userID!).removeValue()
        let tabbar = UIStoryboard.init(name: "Main", bundle: nil)
            guard let mainView = tabbar.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else {return}
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainView, animated: false)
    }
    
}
