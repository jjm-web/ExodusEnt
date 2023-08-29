//
//  KakaoViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/16.
//

import UIKit
import SDWebImage
import SafariServices

class KakaoViewController: UIViewController {


    @IBOutlet var btnKakao: UIButton!
    @IBOutlet var btnKakao2: UIButton!
    @IBOutlet var btnKakao3: UIButton!
    
    var btnUrl_1 : String = "https://v.daum.net/v/20221219154921688"
    var btnUrl_2 : String = "https://v.daum.net/v/20221219143050045"
    var btnUrl_3 : String = "https://v.daum.net/v/20221219092829262"
    
    var btnUrlImage_1: String = "https://img1.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202212/19/sportsdonga/20221219154923006ztmh.jpg"
    var btnUrlImage_2: String = "https://img1.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202212/19/newsen/20221219143053195nkvh.jpg"
    var btnUrlImage_3: String = "https://img4.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202212/19/starnews/20221219092830644iiky.jpg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnUrlImage()

    }
    
    @IBAction func btnKakaoAction_1(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_1)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func btnKakaoAction_2(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_2)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func btnKakaoAction_3(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_3)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    
    
    func btnUrlImage() {
        let transformer = SDImageResizingTransformer(size: CGSize(width: 343, height: 469), scaleMode: .fill)
        
        btnKakao.sd_setImage(with:URL(string: btnUrlImage_1), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btnKakao2.sd_setImage(with:URL(string: btnUrlImage_2), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btnKakao3.sd_setImage(with:URL(string: btnUrlImage_3), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        
        btnKakao.btnImg()
        btnKakao2.btnImg()
        btnKakao3.btnImg()
       
    }

}
