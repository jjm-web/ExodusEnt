//
//  NaverViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/16.
//

import UIKit
import SDWebImage
import SafariServices

class NaverViewController: UIViewController {

    @IBOutlet var btnNav_1: UIButton!
    @IBOutlet var btnNav_2: UIButton!
    @IBOutlet var btnNav_3: UIButton!
    
    var btnUrl_1 : String = "https://www.breaknews.com/939072"
    var btnUrl_2 : String = "https://www.dispatch.co.kr/2228899"
    var btnUrl_3 : String = "https://entertain.naver.com/ranking/read?oid=433&aid=0000089071&rankingType=default&rankingDate="
    
    var btnUrlImage_1: String = "https://www.breaknews.com/imgdata/breaknews_com/202212/202212192511690.jpg"
    var btnUrlImage_2: String = "https://dispatch.cdnser.be/cms-content/uploads/2022/12/05/85ab4135-6823-4da3-8e4e-f3d6754af630.jpeg"
    var btnUrlImage_3: String = "https://mimgnews.pstatic.net/image/433/2022/12/19/0000089071_001_20221219143401589.jpg?type=w540"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnUrlImage()

    }
    
    @IBAction func btnNaverAction_1(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_1)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func btnNaverAction_2(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_2)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func btnNaverAction_3(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_3)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    
    
    func btnUrlImage() {
        let buttonSize = CGSize(width: 343, height: 469)
        let transformer = SDImageResizingTransformer(size: buttonSize, scaleMode: .fill)

        
        if let imageURL = URL(string: btnUrlImage_1) {
            let image = UIImage(named: "your_placeholder_image_name") // Placeholder image
            let resizedImage = image?.sd_resizedImage(with: buttonSize, scaleMode: .fill)
            
            btnNav_1.sd_setImage(with: imageURL, for: .normal, placeholderImage: resizedImage, context: [.imageTransformer: transformer])
        }
        
//        btnNav_1.sd_setImage(with:URL(string: btnUrlImage_1), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btnNav_2.sd_setImage(with:URL(string: btnUrlImage_2), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btnNav_3.sd_setImage(with:URL(string: btnUrlImage_3), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        
        btnNav_1.btnImg()
        btnNav_2.btnImg()
        btnNav_3.btnImg()
       
    }

}
