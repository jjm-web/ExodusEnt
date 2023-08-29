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
    
    @IBOutlet var toolBar: UIToolbar!
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
   
    
    let dataArray: Array<UIImage> = [UIImage(named: "newjeans.png")!, UIImage(named: "newjeans2.png")!, UIImage(named: "newjeans3.png")!]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        toolBar.layer.borderWidth = 1
        toolBar.layer.borderColor = CGColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
        
        instaButton.btnOnLayer()
        twiterButton.btnOffLayer()
        naverButton.btnOffLayer()
        kakaoButton.btnOffLayer()
        
        instaView.isHidden = false
        twiterView.isHidden = true
        naverView.isHidden = true
        kakaoView.isHidden = true
        
        // SNS 버튼 스타일 및 뷰 체인지
        instaButton.addTarget(self, action: #selector(buttonOnOff(button:)), for: .touchUpInside)
        twiterButton.addTarget(self, action: #selector(buttonOnOff(button:)), for: .touchUpInside)
        naverButton.addTarget(self, action: #selector(buttonOnOff(button:)), for: .touchUpInside)
        kakaoButton.addTarget(self, action: #selector(buttonOnOff(button:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabbar()
        navigationController?.isNavigationBarHidden = true
               
        formatter_time.dateFormat = "HH:mm:ss"
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MainViewController.timerAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func buttonOnOff(button: UIButton) {
        switch button {
            // 인스타 버튼 액션 함수 처리
            case instaButton:
                instaButton.btnOnLayer()
                twiterButton.btnOffLayer()
                naverButton.btnOffLayer()
                kakaoButton.btnOffLayer()
            
                instaView.isHidden = false
                twiterView.isHidden = true
                naverView.isHidden = true
                kakaoView.isHidden = true
            // 트위터 버튼 액션 함수 처리
            case twiterButton:
                instaButton.btnOffLayer()
                twiterButton.btnOnLayer()
                naverButton.btnOffLayer()
                kakaoButton.btnOffLayer()
        
                instaView.isHidden = true
                twiterView.isHidden = false
                naverView.isHidden = true
                kakaoView.isHidden = true
            // 네이버 버튼 액션 함수 처리
            case naverButton:
                instaButton.btnOffLayer()
                twiterButton.btnOffLayer()
                naverButton.btnOnLayer()
                kakaoButton.btnOffLayer()
        
                instaView.isHidden = true
                twiterView.isHidden = true
                naverView.isHidden = false
                kakaoView.isHidden = true
            // 카카오 버튼 액션 함수 처리
            default:
                instaButton.btnOffLayer()
                twiterButton.btnOffLayer()
                naverButton.btnOffLayer()
                kakaoButton.btnOnLayer()
        
                instaView.isHidden = true
                twiterView.isHidden = true
                naverView.isHidden = true
                kakaoView.isHidden = false
        }
    }
    
    @objc func timerAction() {
        let timer = formatter_time.string(from: Date())
        lblTimer.text = "랭킹 갱신까지! \(timer)"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
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
        self.setTitleColor(.white, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
    }
    
    func btnOffLayer() {
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0), for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
    }
}
