//
//  InstarGramViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/16.
//

import UIKit
import SDWebImage
import SafariServices

class InstarGramViewController: UIViewController {

    @IBOutlet var btn_1: UIButton!
    @IBOutlet var btn_2: UIButton!
    @IBOutlet var btn_3: UIButton!
 
    var btnUrl_1 : String = "https://www.instagram.com/p/CmNvVsvPVRc/?igshid=YmMyMTA2M2Y%3D"
    var btnUrl_2 : String = "https://www.instagram.com/p/CmGPrp1rGMo/?igshid=YmMyMTA2M2Y%3D"
    var btnUrl_3 : String = "https://www.instagram.com/p/Cl-ZOzTSQ3Y/?igshid=YmMyMTA2M2Y%3D"
    
    var btnUrlImage_1: String = "https://firebasestorage.googleapis.com/v0/b/exodusent-5d233.appspot.com/o/instagrame%2Finstagram1.png?alt=media&token=41eda5b0-a37a-421d-9a0d-9b324228e5ef"
    var btnUrlImage_2: String = "https://firebasestorage.googleapis.com/v0/b/exodusent-5d233.appspot.com/o/instagrame%2Finstagram2.png?alt=media&token=3f4e2fcd-b1c6-41b4-976b-3389d10ba9b4"
    var btnUrlImage_3: String = "https://firebasestorage.googleapis.com/v0/b/exodusent-5d233.appspot.com/o/instagrame%2Finstagram3.png?alt=media&token=5415d9bf-0a51-460b-a574-4564ea5ee771"
    
    @IBAction func btnAction_1(_ sender: UIButton) {
        let blogUrl = NSURL(string: btnUrl_1)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func btnAction_2(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_2)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    
    @IBAction func btnAction_3(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_3)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnUrlImage()

    }
    
    func btnUrlImage() {
        let transformer = SDImageResizingTransformer(size: CGSize(width: 382, height: 469), scaleMode: .aspectFill)
        
        btn_1.sd_setImage(with:URL(string: btnUrlImage_1), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btn_2.sd_setImage(with:URL(string: btnUrlImage_2), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btn_3.sd_setImage(with:URL(string: btnUrlImage_3), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        
        btn_1.btnImg()
        btn_2.btnImg()
        btn_3.btnImg()
       
    }

}

extension UIButton {
    func btnImg() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor // 색깔
       
        self.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        self.layer.shadowRadius = 5 // 반경
        self.layer.shadowOpacity = 0.3 // alpha값
    }
}

