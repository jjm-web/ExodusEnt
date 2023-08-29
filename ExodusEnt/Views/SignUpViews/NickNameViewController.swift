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
   
    @IBOutlet weak var bottomButtonConstraint: NSLayoutConstraint!
    
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
                               self.nextLoveIdol.tintColor = .init(red: 0.51, green: 0.494, blue: 0.49, alpha: 1.0)
                               self.nextLoveIdol.layer.cornerRadius = 28
                               self.nextLoveIdol.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
                               self.nextLoveIdol.layer.masksToBounds = true
                               self.nextLoveIdol.layer.borderWidth = 1
                              
                               break
                           } else if (myNick != self.nickNameText.text) && (sender.text?.isEmpty == false){
                               self.lblNickName.text = "사용 가능한 닉네임 입니다."
                               self.lblNickName.textColor = .black
                               self.nextLoveIdol.isEnabled = true
                               self.nextLoveIdol.layer.backgroundColor = UIColor(red: 0.92, green: 0.334, blue: 0.304, alpha: 1).cgColor
                               self.nextLoveIdol.tintColor = .init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                               self.nextLoveIdol.layer.cornerRadius = 28
                               self.nextLoveIdol.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
                               self.nextLoveIdol.layer.borderWidth = 1
                               self.nextLoveIdol.layer.masksToBounds = true
                           } else {
                               self.lblNickName.text = nil
                               self.nickNameLayout()
                           }
                           
                       }
                       
                   }
            } else {
                self.lblNickName.text = "첫번째 이용자입니다!"
                self.lblNickName.textColor = .black
                self.nextLoveIdol.isEnabled = true
                self.nextLoveIdol.layer.backgroundColor = UIColor(red: 0.92, green: 0.334, blue: 0.304, alpha: 1).cgColor
                self.nextLoveIdol.tintColor = .init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.nextLoveIdol.layer.cornerRadius = 28
                self.nextLoveIdol.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
                self.nextLoveIdol.layer.borderWidth = 1
                self.nextLoveIdol.layer.masksToBounds = true
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        bottomButtonConstraint.constant = 272
        bottomButtonConstraint.priority = UILayoutPriority(750)
        //bottomButtonConstraint.relation = .lessThanOrEqual
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
            if let userInfo = notification.userInfo,
               let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight = keyboardFrame.height
                let safeAreaBottom = view.safeAreaInsets.bottom
                let buttonOffset = keyboardHeight - safeAreaBottom
                bottomButtonConstraint.constant = buttonOffset
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    
    
    func nickNameLayout() {
        nickNameText.addLeftPadding()
        
        nextLoveIdol.isEnabled = false
        nickNameText.layer.cornerRadius = 30
        nickNameText.layer.borderWidth = 1
        
        nickNameText.layer.borderColor = .init(red: 0.846, green: 0.846, blue: 0.846, alpha: 1)
        nextLoveIdol.layer.backgroundColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
        nextLoveIdol.setTitleColor(UIColor.white, for: .normal)
        nickNameText.textColor = .black
        nickNameText.borderStyle = .none
        nickNameText.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.746, green: 0.746, blue: 0.746, alpha: 1)])
    }
    
    func nextBtn() {
        nextLoveIdol.layer.cornerRadius = 28
        nextLoveIdol.layer.borderWidth = 1
        nextLoveIdol.layer.masksToBounds = true
        nextLoveIdol.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
        
        nextLoveIdol.tintColor = .init(red: 0.51, green: 0.49, blue: 0.49, alpha: 1.0)
        nextLoveIdol.backgroundColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if ((textField.text?.count)!  > maxLength) {
            textField.deleteBackward()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        print("\(updatedText.count)/14")
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

