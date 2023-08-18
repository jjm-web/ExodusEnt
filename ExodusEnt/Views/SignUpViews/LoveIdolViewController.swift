//
//  LoveIdolViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/14.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseAuth
import IQKeyboardManagerSwift

class LoveIdolViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var lblNickName: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var lineView: UIView!
    @IBOutlet var searchView: UIView!
    
    var data: String!
    var bestIdol: String!
    
    let storage = Storage.storage()
    
    var groupName = ["blackpink", "twice"/*, "뉴진스", "르세라핌", "아이브", "케플러", "엔믹스", "잇지", "여자아이들", "클라씨",
                                             "방탄소년단", "투모로우바이투게더", "스트레이키즈", "엔씨티", "세븐틴", "위너", "빅뱅", "SF9", "갓세븐", "트레저",
                                             "강다니엘", "지드래곤", "크러쉬", "제이홉", "알엠", "이찬혁", "임영웅", "백현", "카이", "지코",
                                             "선미", "보아", "청하", "권은비", "씨엘", "아이유", "화사", "제시", "현아", "헤이즈"*/]
    
    
    var initialArray: [String] = ["blackpink", "twice"/*, "뉴진스", "르세라핌", "아이브", "케플러", "엔믹스", "잇지", "여자아이들", "클라씨",
                                          "방탄소년단", "투모로우바이투게더", "스트레이키즈", "엔씨티", "세븐틴", "위너", "빅뱅", "SF9", "갓세븐", "트레저",
                                          "강다니엘", "지드래곤", "크러쉬", "제이홉", "알엠", "이찬혁", "임영웅", "백현", "카이", "지코",
                                          "선미", "보아", "청하", "권은비", "씨엘", "아이유", "화사", "제시", "현아", "헤이즈"*/]
    
    var image = ["1.svg", "1.svg"]
    
    @IBAction func next(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier:"ProfileViewController") as? ProfileViewController else { return }
            nextVC.data = data
            nextVC.bestIdol = bestIdol
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
            self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpIdols()
//        setUp()
//        lblNickName!.text = data + "\n의 최애는 누구인가요?"
//        nickNameLayout()
//        nextButton()
//        layoutSubviews()
//        viewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lineView.isHidden = true
        table.isHidden = true
        nextBtn.isEnabled = false
        
        lblNickName!.text = data + "\n의 최애는 누구인가요?"
        
        setUpIdols()
        setUp()
        nickNameLayout()
        nextButton()
        layoutSubviews()
        viewLayout()
        searchBar.text = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func layoutSubviews() {

        table.frame = table.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 100, right: 10))
    }
    
    func viewChange() {
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = .init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        searchView.layer.cornerRadius = 35
        searchView.layer.masksToBounds = true
        
        searchBar.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        searchBar.layer.masksToBounds = true
    }
    
    private func setUpIdols() {
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setUp() {
        searchBar.delegate = self
    }

    func nickNameLayout() {
        let placeholder = "최애를 검색하세요"
        searchBar.placeholder = placeholder
        _ = NSMutableAttributedString(string: placeholder, attributes: [
               NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 16) as Any,
               NSAttributedString.Key.foregroundColor : UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
           ])
        
        searchBar.searchTextField.font = UIFont(name: "Pretendard-Regular", size: 16)
    }
    
    func viewLayout() {
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.clear.cgColor
        searchView.layer.cornerRadius = 35
        searchView.layer.masksToBounds = true

        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.backgroundColor = .white
        searchBar.layer.borderColor = .init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 30
        searchBar.layer.masksToBounds = true
        
       
    }
    
    func nextButton() {
        nextBtn.layer.cornerRadius = 28
        nextBtn.tintColor = .init(red: 0.51, green: 0.49, blue: 0.49, alpha: 1.0)
        nextBtn.backgroundColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }
    
    func buttonChange() {
        nextBtn.layer.cornerRadius = 28
        nextBtn.tintColor = .init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nextBtn.backgroundColor = .init(red: 0.92, green: 0.33, blue: 0.3, alpha: 1.0)
    }
    
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
    
    // Table
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.groupName.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell  = self.table.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
           
           cell.idolName.text = self.groupName[indexPath.row]
           cell.idolImage.image = UIImage(named: image[indexPath.row])
           cell.separatorInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
           
           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.groupName[indexPath.row])
        searchBar.text = self.groupName[indexPath.row]
        nextBtn.isEnabled = true
        buttonChange()
        bestIdol = searchBar.text
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
  
       
       // This two functions can be used if you want to show the search bar in the section header
   //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
   //        return searchBar
   //    }
       
   //    // search bar in section header
   //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
   //        return UITableViewAutomaticDimension
   //    }
       
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text: String = self.searchBar.text ?? ""
        self.groupName = []
        for item in self.initialArray {
            if (item.lowercased().contains(text.lowercased())) {
                self.groupName.append(item)
                lineView.isHidden = false
                table.isHidden = false
                viewChange()
            }
        }
        if (text.isEmpty) {
            self.groupName = self.initialArray
            lineView.isHidden = true
            table.isHidden = true
            nextBtn.isEnabled = false
            nextButton()
            viewLayout()
        }
        self.table.reloadData()
        
    }
    
    
   }


extension UISearchBar {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 27, height: self.frame.height))
      searchTextField.leftView = paddingView
      searchTextField.leftViewMode = UITextField.ViewMode.always
  }
}

