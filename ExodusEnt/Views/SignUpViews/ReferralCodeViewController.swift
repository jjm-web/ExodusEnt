//
//  ReferralCodeViewController.swift
//  
//
//  Created by 장준명 on 2022/12/08.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth
import FirebaseDatabase
import RealmSwift
class ReferralCodeViewController: UIViewController, UITextFieldDelegate {

    var data: String?
    var bestIdol: String?
   
    var birtData: String?
    var sexData: String?
    var countryData: String?
    
    var timeData: String?
    var timeData_2: String?
    var timeData_3: String?
    var timeData_4: String?
    
    var randomCode : String!
    
    var ref: DatabaseReference!
    let realm = try! Realm()
    

    @IBOutlet weak var lblAlert: UILabel!
    
    @IBOutlet var codeTxf: UITextField!
    //@IBOutlet var textCount: UILabel!
    @IBOutlet var lblCode: UILabel!
    
    @IBOutlet var mainBtn: UIButton!
    @IBOutlet var skipBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTxf.addLeftPadding()
        layout()
        codeTxf.delegate = self
        ref = Database.database().reference()
        
        mainBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        skipBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
    }
    
    @objc func btnAction() {

        let alert = UIAlertController(title: "성공", message: "최애돌을 시작해 봅시다!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "시작", style: .default, handler: self.creatUser)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)

    }

    @IBAction func codeAction(_ sender: UITextField) {
        checkMaxLength(textField: codeTxf, maxLength: 7)
        
        ref.child("ExodusEnt").observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                   for userSnapshot in snapshot.children {
                       let userSnap = userSnapshot as! DataSnapshot
                       for childSnapshot in userSnap.children {
                           let childSnap = childSnapshot as! DataSnapshot
    
                           let dict = childSnap.value as! [String: Any]
                           let myCode = dict["code"] as! String
                           print("code: " + myCode)
    
                           if myCode == self.codeTxf.text  {
                               self.lblCode.text = "인증됐습니다."
                               self.lblCode.tintColor = .init(red: 0.79, green: 0.18, blue: 0.31, alpha: 1)
                               break
                           } else if (myCode != self.codeTxf.text) && (sender.text?.isEmpty == false){
                               self.lblCode.text = "코드를 다시 입력해주세요."
                               self.lblCode.textColor = .red
                               
                           } else if sender.text?.isEmpty == true{
                               self.lblCode.text = "추천인 코드를 입력하면 해택이 있어요"
                               self.lblCode.textColor = .black
                           }
                       }
    
                   }
               }
        })
        { error in
          print(error.localizedDescription)
        }
    
    }
    
   
    
    func layout() {
        codeTxf.addLeftPadding()
        codeTxf.layer.borderWidth = 1
        codeTxf.layer.borderColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        codeTxf.layer.cornerRadius = 30
        codeTxf.layer.masksToBounds = true
        
        lblAlert.layer.cornerRadius = 16
        lblAlert.layer.masksToBounds = true
        
    }
    
    func creatUser(alert: UIAlertAction!) {
        
        let userNickname = data
        var userBestIdol = bestIdol
        let userBirtData = birtData
        let userSexData = sexData
        let userCountryData = countryData
        let userTimeData = timeData
        let userTimeData_2 = timeData_2
        let userTimeData_3 = timeData_3
        let userTimeData_4 = timeData_4
        let user = Auth.auth().currentUser
        let email = user?.email
        //강제 형 변환으로 var값 설정
        var uid = user?.uid
        let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let size = 7
        randomCode = str.createRandomStr(length: size)
        print(randomCode!)
        
        let realmWrith = Profile()
        
        realmWrith.name = userNickname
        realmWrith.bestIdol = userBestIdol
        realmWrith.birth = userBirtData
        realmWrith.gender = userSexData
        realmWrith.country = userCountryData
        realmWrith.time = userTimeData
        realmWrith.time_2 = userTimeData_2
        realmWrith.time_3 = userTimeData_3
        realmWrith.time_4 = userTimeData_4
        
//        @Persisted(primaryKey: true) var id: ObjectId
//        @Persisted var name: String?
//        @Persisted var Birth: String?
//        @Persisted var gender: String?
//        @Persisted var country: String?
//        @Persisted var time: String?
//        @Persisted var time_2: String?
//        @Persisted var time_3: String?
//        @Persisted var time_4: String?
//        @Persisted var email: String?
//        @Persisted var code: String?
        
        
        
        // 추가 정보 입력
        ref.child("ExodusEnt").child("UserAccount").child(uid!).setValue(["idToken": uid!,
                                                                              "name": userNickname,
                                                                              "bestIdol": userBestIdol,
                                                                              "birtDay" : userBirtData,
                                                                              "sex": userSexData,
                                                                              "country":  userCountryData,
                                                                              "time" : userTimeData,
                                                                              "time_2" : userTimeData_2,
                                                                              "time_3" : userTimeData_3,
                                                                              "time_4": userTimeData_4,
                                                                              "email": email,
                                                                              "code" : randomCode,
                                                                     ])
        do {
            try realm.write {
                realm.add
            }
        } catch {
            realm.add(realmWrith)
            
        }
        

        self.firebaseAuth()
    }
    
    func rootView() {
        let tabbar = UIStoryboard.init(name: "Main", bundle: nil)
            guard let mainView = tabbar.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {return}
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainView, animated: false)
    }
    
    func firebaseAuth() {
        
        if Auth.auth().currentUser != nil {
            self.rootView()
        } else {
          // No user is signed in.
          // ...
        }
    }
    
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if ((textField.text?.count)!  > maxLength) {
            textField.deleteBackward()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = codeTxf.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 7
    }

}

extension String {

    func createRandomStr(length: Int) -> String {
        let str = (0 ..< length).map{ _ in self.randomElement()! }
        return String(str)
    }
    
}


