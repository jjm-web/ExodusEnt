//
//  ContentsViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/14.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ContentsViewController: UIViewController {

    @IBOutlet var mainBannerCollection: UICollectionView!
    
    @IBOutlet var lblTimer: UILabel!

    @IBOutlet var lblMyNick: UILabel!
    @IBOutlet var lblMyLevel: UILabel!
    @IBOutlet var lblMyHeart: UILabel!
    @IBOutlet var lblMyDia: UILabel!
    
    @IBOutlet var myIdolImg: UIImageView!
    
    @IBOutlet var attendView: UIView!
    @IBOutlet var freeChargeView: UIView!
    @IBOutlet var quizeView: UIView!
    @IBOutlet var resemblanceVIew: UIView!
    
    let mainImageArray: Array<UIImage> = [UIImage(named: "benner_1.jpeg")!, UIImage(named: "benner_2.jpeg")!, UIImage(named: "benner_3.jpeg")!]
    
    var nowPage: Int = 0
    var formatter_time = DateFormatter()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        bannerTimer()
        mainBannerCollection.delegate = self
        mainBannerCollection.dataSource = self
        userPryvacy()
        
        attendView.viewLayOut()
        freeChargeView.viewLayOut()
        quizeView.viewLayOut()
        resemblanceVIew.viewLayOut()
        
        myIdolImg.layer.cornerRadius = 8
        lblMyLevel.layer.cornerRadius = 3
        lblMyLevel.layer.masksToBounds = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabbar()
        navigationController?.isNavigationBarHidden = true
        
        formatter_time.dateFormat = "HH:mm:ss"
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MainViewController.timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        let timer = formatter_time.string(from: Date())
        lblTimer.text = "랭킹 갱신까지! \(timer)"
    }
    
    func userPryvacy() {
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("name").observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblMyNick.text = value
            }
                }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("level").observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblMyLevel.text = "Lv.\(value)"
            }
                }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("heart").observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblMyHeart.text = value
            }
                }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("diamond").observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.lblMyDia.text = value
            }
                }) { error in
            print(error.localizedDescription)
        }
        
        ref.child("ExodusEnt").child("UserAccount").child(userID!).child("bestIdol").observeSingleEvent(of: .value, with: { snapshot in
        let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.myIdolImg.image = UIImage(named: "\(value).svg")
            }
                }) { error in
            print(error.localizedDescription)
        }
        
    }
    
    
    // 2초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
        // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == mainImageArray.count-1 {
        // 맨 처음 페이지로 돌아감
            mainBannerCollection.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        mainBannerCollection.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
}

extension ContentsViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mainBannerCollection.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! ContentCell
        cell.mainImage.image = mainImageArray[indexPath.row]
        cell.mainImage.layer.borderWidth = 1
        cell.mainImage.layer.cornerRadius = 16
        cell.mainImage.layer.masksToBounds = true
        
        return cell
    }
}

extension UIView {
    func viewLayOut(){
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
    }
}
