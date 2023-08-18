//
//  ProfileViewController.swift
//  
//
//  Created by 장준명 on 2022/12/08.
//

import UIKit
import IQKeyboardManagerSwift
class ProfileViewController: UIViewController, SampleProtocol {

    var data: String!
    var bestIdol: String!
   
    var birtData: String!
    var sexData: String!
    var countryData: String!
    
    var timeData:String!
    var timeData_2:String!
    var timeData_3:String!
    var timeData_4:String!
    
    @IBOutlet var birthTxf: UITextField!
    @IBOutlet var countryTxf: UITextField!
    
    @IBOutlet var manBtn: UIButton!
    @IBOutlet var gireBtn: UIButton!
   
    @IBOutlet var manBtnOff: UIButton!
    @IBOutlet var gireBtnOff: UIButton!
    
    @IBOutlet var sixTimBtn: UIButton!
    @IBOutlet var forteenBtn: UIButton!
    @IBOutlet var ttytoBtn: UIButton!
    @IBOutlet var differentBtn: UIButton!
    
    @IBOutlet var sixTimBtnOff: UIButton!
    @IBOutlet var forteenBtnOff: UIButton!
    @IBOutlet var ttytoBtnOff: UIButton!
    @IBOutlet var differentBtnOff: UIButton!
    
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var countyBtn: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        countyBtn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

    }

    @objc
    private func didTapButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier:"CountyViewController") as? CountyViewController else { return }
        nextVC.delegate = self
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtLayout()
    }
    
    @IBAction func manCheck(_ sender: UIButton) {
        manBtnOff.isHidden = false
    }
    
    // 남성 선택
    @IBAction func manCheckOff(_ sender: UIButton) {
        manBtnOff.isHidden = true
        gireBtnOff.isHidden = false
        sexData = "남성"
    }
    
    @IBAction func gireCheck(_ sender: UIButton) {
        gireBtnOff.isHidden = false
    }
    
    // 여성 선택
    @IBAction func gireCheckOff(_ sender: UIButton) {
        gireBtnOff.isHidden = true
        manBtnOff.isHidden = false
        sexData = "여성"
    }
    
    @IBAction func sixCheck(_ sender: UIButton) {
        sixTimBtnOff.isHidden = false
    }
    
    @IBAction func sixCheckOff(_ sender: UIButton) {
        sixTimBtnOff.isHidden = true
        timeData = "06:00 ~ 14:00"
    }
    
    @IBAction func forteenCheck(_ sender: UIButton) {
        forteenBtnOff.isHidden = false
    }
    
    @IBAction func forteenCheckOff(_ sender: UIButton) {
        forteenBtnOff.isHidden = true
        timeData_2 = "14:00 ~ 22:00"
    }
    
    @IBAction func ttytoBtn(_ sender: UIButton) {
        ttytoBtnOff.isHidden = false
    }
    
    @IBAction func ttytoBtnOff(_ sender: UIButton) {
        ttytoBtnOff.isHidden = true
        timeData_3 = "22:00 ~ 06:00"
    }
    
    @IBAction func differentBtn(_ sender: UIButton) {
        differentBtnOff.isHidden = false
    }
    
    @IBAction func differentBtnOff(_ sender: UIButton) {
        differentBtnOff.isHidden = true
        timeData_4 = "그때 그때 다름"
    }
    
    
    @IBAction func nextBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier:"ReferralCodeViewController") as? ReferralCodeViewController else { return }
            nextVC.data = data
            nextVC.bestIdol = bestIdol
            nextVC.birtData = birtData
            nextVC.countryData = countryData
            nextVC.sexData = sexData
            nextVC.timeData = timeData
            nextVC.timeData_2 = timeData_2
            nextVC.timeData_3 = timeData_3
            nextVC.timeData_4 = timeData_4
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
            self.dismiss(animated: true)
    }
    
    func txtLayout() {
        birthTxf.padding()
        birthTxf.layer.cornerRadius = 25
        birthTxf.layer.borderColor = .init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        birthTxf.layer.borderWidth = 1
        birthTxf.layer.masksToBounds = true
        
        countryTxf.padding()
        countryTxf.layer.cornerRadius = 25
        countryTxf.layer.borderColor = .init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        countryTxf.layer.borderWidth = 1
        countryTxf.layer.masksToBounds = true
    }
    
    func dataSend(countryData: String) {
        countryTxf.text = countryData
        
      }
}

extension UITextField {
  func padding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
