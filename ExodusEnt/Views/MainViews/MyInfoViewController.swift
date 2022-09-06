//
//  MyInfoViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/12/14.
//

import UIKit

class MyInfoViewController: UIViewController {
    
    var formatter_time = DateFormatter()
    var btnLists : [UIButton] = []
        
        var currentIndex : Int = 0 {
            didSet{
                changeBtnColor()
                print(currentIndex)
            }
        }
    
    func changeBtnColor(){
        for (index, element) in btnLists.enumerated(){
            if index == currentIndex{
                element.tintColor =  UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
                element.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 5.0)
                
            }
            else{
                element.tintColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
                element.layer.addBorder([.bottom], color: UIColor.white, width: 5.0)
            }
                
        }
            
    }
    
    @IBOutlet weak var lblTimer: UILabel!
    
    @IBOutlet weak var myPrivacyBtn: UIButton!
    @IBOutlet weak var userHistoryBtn: UIButton!
    
    var pageViewController : PageViewController!
    
    @objc func timerAction() {
        let timer = formatter_time.string(from: Date())
        lblTimer.text = "랭킹 갱신까지! \(timer)"
    }
    
    func beforSetBtnList(){
        myPrivacyBtn.tintColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        myPrivacyBtn.layer.addBorder([.bottom], color: UIColor(red: 0.92, green: 0.33, blue: 0.3, alpha: 1), width: 5.0)
        
        userHistoryBtn.tintColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
        userHistoryBtn.layer.addBorder([.bottom], color: UIColor.white, width: 0)
        btnLists.append(myPrivacyBtn)
        btnLists.append(userHistoryBtn)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter_time.dateFormat = "HH:mm:ss"
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MainViewController.timerAction), userInfo: nil, repeats: true)
        
        beforSetBtnList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabbar()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PVCSegue" {
            print("Connected")
                guard let vc = segue.destination as? PageViewController else {return}
                pageViewController = vc
                        
                pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    
    @IBAction func btnSelect_1(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    
    @IBAction func btnSelect_2(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
    
}
