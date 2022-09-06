//
//  NickNameViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/09/29.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import IQKeyboardManagerSwift

class NickNameViewController: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    var data: String!
    
    @IBOutlet var nickNameText: UITextField!
    @IBOutlet var lblNickName: UILabel!
    @IBOutlet var nextLoveIdol: UIButton!
    @IBOutlet var progerss: UIProgressView!
    @IBOutlet var textCount: UILabel!
   
    @IBAction func nickName(_ sender: UITextField) {
        checkMaxLength(textField: nickNameText, maxLength: 14)
        
        //let userID = Auth.auth().currentUser?.uid
        ref.child("ExodusEnt").observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                   for userSnapshot in snapshot.children {
                       let userSnap = userSnapshot as! DataSnapshot
                       for childSnapshot in userSnap.children {
                           let childSnap = childSnapshot as! DataSnapshot

                           let dict = childSnap.value as! [String: Any]
                           let myNick = dict["name"] as! String
                           print("name: " + myNick)
                           
                           if (myNick == self.nickNameText.text) {
                               self.lblNickName.text = "중복된 닉네임입니다"
                               self.lblNickName.textColor = .red
                               self.nextLoveIdol.isEnabled = false
                               self.nextLoveIdol.layer.backgroundColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
                               self.nextLoveIdol.setTitleColor(UIColor.white, for: .normal)
                               self.nextLoveIdol.layer.cornerRadius = 32
                               break
                           } else if (myNick != self.nickNameText.text) && (sender.text?.isEmpty == false){
                               self.lblNickName.text = "사용가능한 닉네임입니다."
                               self.lblNickName.textColor = .green
                               
                               self.nextLoveIdol.isEnabled = true
                               self.nextLoveIdol.layer.backgroundColor = UIColor(red: 0.92, green: 0.334, blue: 0.304, alpha: 1).cgColor
                               self.nextLoveIdol.setTitleColor(.white, for: .normal)
                               self.nextLoveIdol.layer.cornerRadius = 32
                               
                           } else if sender.text?.isEmpty == true{
                               self.lblNickName.text = nil
                               self.nickNameLayout()
                           } else {
                               self.lblNickName.text = "사용가능한 닉네임입니다."
                               self.lblNickName.textColor = .green
                               
                               self.nextLoveIdol.isEnabled = true
                               self.nextLoveIdol.layer.backgroundColor = UIColor(red: 0.92, green: 0.334, blue: 0.304, alpha: 1).cgColor
                               self.nextLoveIdol.setTitleColor(.white, for: .normal)
                               self.nextLoveIdol.layer.cornerRadius = 32
                           }
                           
                       }
                       
                   }
               }
        })
        { error in
          print(error.localizedDescription)
        }
    }
   

    @IBAction func nextBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier:"LoveIdolViewController") as? LoveIdolViewController else { return }
            nextVC.data = self.nickNameText.text
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        nickNameText.delegate = self
        nickNameLayout()
        nextBtn()
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func nickNameLayout() {
        nickNameText.addLeftPadding()
        nickNameText.layer.cornerRadius = 30
        nickNameText.layer.borderColor = .init(red: 0.846, green: 0.846, blue: 0.846, alpha: 1)
        nickNameText.layer.borderWidth = 1
        nextLoveIdol.layer.backgroundColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
        nextLoveIdol.setTitleColor(UIColor.white, for: .normal)
        nickNameText.textColor = .black
        nickNameText.borderStyle = .none
        nickNameText.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.746, green: 0.746, blue: 0.746, alpha: 1)])
        nextLoveIdol.isEnabled = false
    }
    
    func nextBtn() {
        nextLoveIdol.layer.cornerRadius = 30
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if ((textField.text?.count)!  > maxLength) {
            textField.deleteBackward()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = nickNameText.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        
        if updatedText.count >= 15 {
            textCount.text = "14/14"
            textField.deleteBackward()
        } else {
            textCount.text = "\(updatedText.count)/14"
        }
        return true
    }
    
}


extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 27, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
