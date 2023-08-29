//
//  TwiterViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/16.
//

import UIKit
import SDWebImage
import SafariServices

class TwiterViewController: UIViewController {

    @IBOutlet var btnTwi_1: UIButton!
    @IBOutlet var btnTwi_2: UIButton!
    @IBOutlet var btnTwi_3: UIButton!
    
    var btnUrl_1 : String = "https://twitter.com/BLACKPINK/status/1603650043365433344/photo/1"
    var btnUrl_2 : String = "https://twitter.com/billboard/status/1603546343708188673?cxt=HHwWgoDT2eq5-MAsAAAA"
    var btnUrl_3 : String = "https://twitter.com/pledis_17/status/1548955744279592960/photo/1"
    
    var btnUrlImage_1: String = "https://pbs.twimg.com/media/FkFPF3DUYAEZqTL?format=jpg&name=small"
    var btnUrlImage_2: String = "https://www.publimetro.com.mx/resizer/e8B2Af8TO53Kut6d9LbXZlgTNcU=/800x0/filters:format(jpg):quality(70)/cloudfront-us-east-1.images.arcpublishing.com/metroworldnews/IJO3F46CCBA6XHUYG4A3GOQXOA.jpg"
    var btnUrlImage_3: String = "https://pbs.twimg.com/media/FX2tPxpaAAAY_Nb?format=jpg&name=large"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnUrlImage()
    }
    
    
    @IBAction func btnTwitAction_1(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_1)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func btnTwitAction_2(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_2)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    @IBAction func btnTwitAction_3(_ sender: Any) {
        let blogUrl = NSURL(string: btnUrl_3)
        let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    
    func btnUrlImage() {
        let transformer = SDImageResizingTransformer(size: CGSize(width: 343, height: 469), scaleMode: .fill)
        
        btnTwi_1.sd_setImage(with:URL(string: btnUrlImage_1), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btnTwi_2.sd_setImage(with:URL(string: btnUrlImage_2), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        btnTwi_3.sd_setImage(with:URL(string: btnUrlImage_3), for: .normal, placeholderImage: nil, context: [.imageTransformer: transformer])
        
        btnTwi_1.btnImg()
        btnTwi_2.btnImg()
        btnTwi_3.btnImg()
       
    }

}
