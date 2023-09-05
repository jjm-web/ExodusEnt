//
//  RangKingViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/18.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import FirebaseStorage
import IQKeyboardManagerSwift
class RangKingViewController: UIViewController {
    
    let storage = Storage.storage()
    let disposeBag = DisposeBag()
    
    var formatter_time = DateFormatter()
    var urlString: String = "gs://exodusent-5d233.appspot.com/"
    var pageViewController: PageViewController!
    
    @IBOutlet var soloBoyView: UIStackView!
    @IBOutlet var soloGireView: UIStackView!
    @IBOutlet var groupBoyView: UIStackView!
    @IBOutlet var groupGireView: UIStackView!
    
    // 걸그룹 이미지
    @IBOutlet var imgGireGroup_1: UIImageView!
    @IBOutlet var imgGireGroup_2: UIImageView!
    @IBOutlet var imgGireGroup_3: UIImageView!
    // 보이그룹 이미지
    @IBOutlet var imgBoyGroup_1: UIImageView!
    @IBOutlet var imgBoyGroup_2: UIImageView!
    @IBOutlet var imgBoyGroup_3: UIImageView!
    // 여자 솔로 이미지
    @IBOutlet var imgSoloGire_1: UIImageView!
    @IBOutlet var imgSoloGire_2: UIImageView!
    @IBOutlet var imgSoloGire_3: UIImageView!
    // 남자 솔로 이미지
    @IBOutlet var imgSoloBoy_1: UIImageView!
    @IBOutlet var imgSoloBoy_2: UIImageView!
    @IBOutlet var imgSoloBoy_3: UIImageView!
    // 로딩 화면
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // 로딩중 회색 화면
    @IBOutlet var loadingOverlay: UIView!
    @IBOutlet var lblTimer: UILabel!
    
    @IBOutlet var segmented: UISegmentedControl!
    
    var currentIndex: Int = 0 {
            didSet{
               
                print(currentIndex)
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        groupGireView.isHidden = false
        groupBoyView.isHidden = true
        soloGireView.isHidden = true
        soloBoyView.isHidden = true
        
        fetchAndLoadImages()
        
        pageViewController?.completeHandler = { [weak self] (result) in
            self?.currentIndex = result
            self?.segmented.selectedSegmentIndex = result
            self?.segmented.changeUnderlinePosition() // 세그먼트 선택 UI 업데이트
        }
        
        segmented.addUnderlineForSelectedSegment()
        segmented.selectedSegmentIndex = currentIndex
        // Load images using RxSwift
        segmented.addTarget(self, action: #selector(loadImages(segment:)), for: .valueChanged)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PageViewController" {
            guard let vc = segue.destination as? PageViewController else { return }
            pageViewController = vc
            pageViewController.completeHandler = { [weak self] result in
                self?.segmented.selectedSegmentIndex = result
            }
        }else {
            print("error")
        }
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
    
    func fetchAndLoadImages() {
        let imageGroupNames = ["giregroupidol", "boygroupidol", "giresoloidol", "boysoloidol"]
           
        var imageURLs: [String] = []
           
        for groupName in imageGroupNames {
            for i in 1...3 {
                let imageName = "\(groupName)/\(groupName)_\(i).jpeg"
                imageURLs.append(imageName)
            }
        }
        loadImages(imageURLs)
    }
       
    func loadImages(_ imageURLs: [String]) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://exodusent-5d233.appspot.com/") // Firebase Storage URL 설정
           
        let imageRequests = imageURLs.map { imageName in
            return Observable<Data>.create { observer in
        let imageRef = storageRef.child(imageName)
            imageRef.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
            if let data = data {
                observer.onNext(data)
                observer.onCompleted()
                } else {
                    observer.onError(error ?? NSError())
                }
            }
                return Disposables.create()
            }
        }
         
        loadingOverlay.isHidden = false // 회색 화면 표시
        
        Observable.zip(imageRequests)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] imageDataArray in
                for (index, imageData) in imageDataArray.enumerated() {
                    if let image = UIImage(data: imageData) {
                        switch index {
                            
                            case 0: self?.imgGireGroup_1.image = image
                            case 1: self?.imgGireGroup_2.image = image
                            case 2: self?.imgGireGroup_3.image = image
                            
                            case 3: self?.imgBoyGroup_1.image = image
                            case 4: self?.imgBoyGroup_2.image = image
                            case 5: self?.imgBoyGroup_3.image = image
                            
                            case 6: self?.imgSoloGire_1.image = image
                            case 7: self?.imgSoloGire_2.image = image
                            case 8: self?.imgSoloGire_3.image = image
                                   
                            case 9: self?.imgSoloBoy_1.image = image
                            case 10: self?.imgSoloBoy_2.image = image
                            case 11: self?.imgSoloBoy_3.image = image
                               
                            default: break
                        }
                    }
                }
                   
                self?.activityIndicator.stopAnimating() // 로딩 뷰 감추기
                self?.activityIndicator.isHidden = true
                self?.loadingOverlay.isHidden = true // 회색 화면 감추기
            }, onError: { error in
                print("Error loading images: \(error)")
            })
            .disposed(by: disposeBag)
    }

    @objc func loadImages(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
            case 0:
                pageViewController.setViewcontrollersFromIndex(index: 0)
            case 1:
                pageViewController.setViewcontrollersFromIndex(index: 1)
            case 2:
                pageViewController.setViewcontrollersFromIndex(index: 2)
            case 3:
                pageViewController.setViewcontrollersFromIndex(index: 3)
            default:
                break
        }
        segmented.changeUnderlinePosition() // 세그먼트 선택 UI 업데이트
    }
}

extension UIView {
    func viewBottomLine(color:UIColor,height:Double) {
        //Hiding Default Line and Shadow
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true

    }
}


