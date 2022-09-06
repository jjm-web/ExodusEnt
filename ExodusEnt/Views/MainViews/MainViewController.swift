//
//  MainViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/19.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var bannerCollectionView: UICollectionView!
    
    @IBOutlet var mainBannerView: UIView!
    
    @IBOutlet weak var myIdolNews: UIButton!
    @IBOutlet weak var rangkingBtn: UIButton!
    @IBOutlet weak var comunitiBtn: UIButton!
    
    @IBOutlet weak var stackBtn: UIStackView!
    
    @IBOutlet var newsButton: UIButton!
    @IBOutlet var instaButton: UIButton!
    @IBOutlet var twiterButton: UIButton!
    @IBOutlet var naverButton: UIButton!
    @IBOutlet var kakaoButton: UIButton!
    
    @IBOutlet var instaView: UIView!
    @IBOutlet var twiterView: UIView!
    @IBOutlet var naverView: UIView!
    @IBOutlet var kakaoView: UIView!
    
    @IBOutlet var lblTimer: UILabel!
    
    var formatter_time = DateFormatter()
   
    
    let dataArray: Array<UIImage> = [UIImage(named: "newjeans1.png")!, UIImage(named: "newjeans2.png")!, UIImage(named: "newjeans3.png")!]


    override func viewDidLoad() {
        super.viewDidLoad()

        instaButton.btnOnLayer()
        twiterButton.btnOffLayer()
        naverButton.btnOffLayer()
        kakaoButton.btnOffLayer()
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
                
        myIdolNews.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 2.0)
        
        instaView.isHidden = false
        twiterView.isHidden = true
        naverView.isHidden = true
        kakaoView.isHidden = true
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func btnInstaAction(_ sender: UIButton) {
        instaView.isHidden = false
        twiterView.isHidden = true
        naverView.isHidden = true
        kakaoView.isHidden = true
        
        instaButton.btnOnLayer()
        twiterButton.btnOffLayer()
        naverButton.btnOffLayer()
        kakaoButton.btnOffLayer()
    }
    
    @IBAction func btnTwiterAction(_ sender: UIButton) {
        instaView.isHidden = true
        twiterView.isHidden = false
        naverView.isHidden = true
        kakaoView.isHidden = true
        
        instaButton.btnOffLayer()
        twiterButton.btnOnLayer()
        naverButton.btnOffLayer()
        kakaoButton.btnOffLayer()
    }
    @IBAction func btnNaverAction(_ sender: UIButton) {
        instaView.isHidden = true
        twiterView.isHidden = true
        naverView.isHidden = false
        kakaoView.isHidden = true
        
        instaButton.btnOffLayer()
        twiterButton.btnOffLayer()
        naverButton.btnOnLayer()
        kakaoButton.btnOffLayer()
        
    }
    @IBAction func btnKakaoAction(_ sender: UIButton) {
        instaView.isHidden = true
        twiterView.isHidden = true
        naverView.isHidden = true
        kakaoView.isHidden = false
        
        instaButton.btnOffLayer()
        twiterButton.btnOffLayer()
        naverButton.btnOffLayer()
        kakaoButton.btnOnLayer()
    }
    
  
    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //컬렉션뷰 개수 설정
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArray.count // Replace with count of your data for collectionViewA
            
    }
    
    
    //컬렉션뷰 셀 설정
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.subImg.image = dataArray[indexPath.row]
        return cell
                          
    }
    
//    // UICollectionViewDelegateFlowLayout 상속
//    //컬렉션뷰 사이즈 설정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: bannerCollectionView.frame.size.width  , height:  bannerCollectionView.frame.height)
//    }
    
    //컬렉션뷰 감속 끝났을 때 현재 페이지 체크
    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


extension CALayer {
    func btnAddBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    func btnOnLayer() {
        self.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.cornerCurve = .continuous
    }
    
    func btnOffLayer() {
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0), for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.cornerCurve = .continuous
    }
}
