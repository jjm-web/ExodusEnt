//
//  RangKingViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/18.
//

import UIKit
import SDWebImage
import FirebaseStorage

class RangKingViewController: UIViewController {
    
    let storage = Storage.storage()
    var formatter_time = DateFormatter()
    var btnLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet{
            changeBtnColor()
            print(currentIndex)
        }
    }
    

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func changeBtnColor(){
        for (index, element) in btnLists.enumerated(){
            if (index == currentIndex) && (currentIndex == 0){
                imgSelect_1()
                element.tintColor =  UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
                element.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 5.0)
            } else if (index == currentIndex) && (currentIndex == 1){
                imgSelect_2()
                element.tintColor =  UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
                element.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 5.0)
            } else if (index == currentIndex) && (currentIndex == 2){
                imgSelect_3()
                element.tintColor =  UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
                element.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 5.0)
            } else if (index == currentIndex) && (currentIndex == 3){
                imgSelect_4()
                element.tintColor =  UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
                element.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 5.0)
            } else {
                element.tintColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
                element.layer.addBorder([.bottom], color: UIColor.white, width: 5.0)
            }
                
        }
            
    }
    
    @IBOutlet var img_1: UIImageView!
    @IBOutlet var img_2: UIImageView!
    @IBOutlet var img_3: UIImageView!
    
    @IBOutlet var lblTimer: UILabel!
    
    @IBOutlet weak var btnBoySolo: UIButton!
    @IBOutlet weak var btnGireSolo: UIButton!
    @IBOutlet weak var btnBoyGroup: UIButton!
    @IBOutlet weak var btnGireGroup: UIButton!
    
    var pageViewController : RangkingPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beforSetBtnList()
    }
    
    @objc func timerAction() {
        let timer = formatter_time.string(from: Date())
        lblTimer.text = "랭킹 갱신까지! \(timer)"
    }
    
    func beforSetBtnList(){
        btnBoySolo.tintColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        btnBoySolo.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 2.0)
        
        btnGireSolo.tintColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        btnGireSolo.layer.addBorder([.bottom], color: UIColor.white, width: 0)
        
        btnBoyGroup.tintColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        btnBoyGroup.layer.addBorder([.bottom], color: UIColor.white, width: 0)
        
        btnGireGroup.tintColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        btnGireGroup.layer.addBorder([.bottom], color: UIColor.white, width: 0)
        
        btnLists.append(btnBoySolo)
        btnLists.append(btnGireSolo)
        btnLists.append(btnBoyGroup)
        btnLists.append(btnGireGroup)
        
        imgSelect_1()
        
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabbar()
        
        navigationController?.isNavigationBarHidden = true
        
        formatter_time.dateFormat = "HH:mm:ss"
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MainViewController.timerAction), userInfo: nil, repeats: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PVCSegue" {
            print("Connected")
                guard let vc = segue.destination as? RangkingPageViewController else {return}
                pageViewController = vc
                        
                pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func select_1(_ sender: Any) {
        pageViewController.reverseSetViewcontrollersFromIndex(index: 0)
        imgSelect_1()

    }
    func imgSelect_1(){
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boysoloidol/boy_1.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_1.image = image
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boysoloidol/boy_2.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_2.image = image
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boysoloidol/boy_3.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_3.image = image
        }
    }
    
    @IBAction func select_2(_ sender: Any) {
        if (currentIndex == 0){
            pageViewController.setViewcontrollersFromIndex(index: 1)
        } else {
            pageViewController.reverseSetViewcontrollersFromIndex(index: 1)
        }
        imgSelect_2()
      
    }
    
    func imgSelect_2(){
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giresoloidol/gire_1.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_1.image = image
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giresoloidol/gire2.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_2.image = image
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giresoloidol/gire_3.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_3.image = image
        }
        
    }
    
    
    @IBAction func select_3(_ sender: Any) {
        
        if (currentIndex == 0) || (currentIndex == 1){
            pageViewController.setViewcontrollersFromIndex(index: 2)
        } else {
            pageViewController.reverseSetViewcontrollersFromIndex(index: 2)
        }
      
        imgSelect_3()
    }
    
    func imgSelect_3(){
        
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boygroupidol/boygroup_1.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_1.image = image
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boygroupidol/boygroup_2.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_2.image = image
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/boygroupidol/boygroup_3.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_3.image = image
        }
    }
    
    @IBAction func select_4(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 3)
        imgSelect_4()
    }
    
    func imgSelect_4(){
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giregroupidol/giregroup_1.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_1.image = image
            
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giregroupidol/giregroup_2.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_2.image = image
        }
        storage.reference(forURL: "gs://exodusent-5d233.appspot.com/giregroupidol/giregroup_3.jpeg").downloadURL { url, error in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.img_3.image = image
        }
    }
    
}


extension UIView {
    func viewBottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        self.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true

    }
}


