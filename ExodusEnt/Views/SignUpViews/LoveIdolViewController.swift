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
    
    var groupName = ["blackpink", "twice", "newjeans", "lesserafim", "ive", "kepler", "nmixx", "itzy", "g-idel", "classy","bts", "txt", "straykids", "nct", "seventeen", "winner", "enhypen", "SF9", "got7","treasure",
                     "kangdaniel", "gdragon", "crush", "jhope","rm", "v", "youngwoong", "backhyun", "kai", "zico",
                     "sunmi", "boa", "chungha", "eunbi", "cl", "iu", "hwasa", "jessi", "hyuna","heize"]
    
    
    var initialArray = ["blackpink", "twice", "newjeans", "lesserafim", "ive", "kepler", "nmixx", "itzy", "g-idel", "classy", "bts", "txt", "straykids", "nct", "seventeen", "winner", "enhypen", "SF9", "got7","treasure", "kangdaniel", "gdragon", "crush", "jhope","rm", "v", "youngwoong", "backhyun", "kai", "zico",
                                  "sunmi", "boa", "chungha", "eunbi", "cl", "iu", "hwasa", "jessi", "hyuna","heize"]
    
    var image = ["blackpink.jpeg", "twice.jpeg", "newjeans.jpeg", "lesserafim.jpeg", "ive.jpeg", "kepler.jpeg", "nmixx.jpeg", "itzy.jpeg", "g-idel.jpeg", "classy.jpeg",
                 "bts.jpeg", "txt.jpeg", "straykids.jpeg", "nct.jpeg", "seventeen.jpeg", "winner.jpeg", "enhypen.jpeg", "SF9.jpeg", "got7.jpeg","treasure.jpeg",
                 "kangdaniel.jpeg", "gdragon.jpeg", "crush.jpeg", "jhope.jpeg","rm.jpeg", "v.jpeg", "youngwoong.jpeg", "backhyun.jpeg", "kai.jpeg", "zico.jpeg",
                 "sunmi.jpeg", "boa.jpeg", "chungha.jpeg", "eunbi.jpeg", "cl.jpeg", "iu.jpeg", "hwasa.jpeg", "jessi.jpeg", "hyuna.jpeg","heize.jpeg"]
    
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
        searchBar.afterAddLeftPadding()
        
    }
    
    func setUpIdols() {
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    func setUp() {
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
        searchBar.addLeftPadding()
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
        nextBtn.layer.cornerRadius = 30
        nextBtn.tintColor = .init(red: 0.51, green: 0.49, blue: 0.49, alpha: 1.0)
        nextBtn.backgroundColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }
    
    func buttonChange() {
        nextBtn.layer.cornerRadius = 30
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
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return groupName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell  = self.table.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
           
        cell.idolName.text = groupName[indexPath.row]
        cell.idolImage.image = UIImage(named: image[indexPath.item])
        cell.idolImage.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(groupName[indexPath.row])
        searchBar.text = groupName[indexPath.row]
        nextBtn.isEnabled = true
        buttonChange()
        bestIdol = searchBar.text
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text: String = self.searchBar.text ?? ""
        self.groupName = []
        self.image = []
        for item in (self.initialArray) {
            if (item.lowercased().contains(text.lowercased())) {
                self.groupName.append(item)
                self.image.append("\(item).jpeg")
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
            return
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
    
    func afterAddLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
    }
}



//["블랙핑크":"blackpink", "트와이스":"twice", "뉴진스":"newjeans", "르세라핌":"lesserafim", "아이브":"ive", "케플러":"kepler", "엔믹스":"nmixx", "잇지":"itzy", "여자아이들":"idel", "클라씨": "classy",
//                 "방탄소년단":"bts", "투모로우바이투게더":"txt", "스트레이키즈":"straykids", "엔씨티":"nct", "세븐틴":"seventeen", "위너":"winner", "엔하이픈":"enhypen", "에스에프나인":"SF9", "갓세븐":"got7", "트레저":"treasure",
//                 "강다니엘":"kangdaniel", "지드래곤":"gdragon", "크러쉬":"crush", "제이홉":"jhope","알엠":"rm", "브이":"v", "임영웅":"youngwoong", "백현":"backhyun", "카이":"kai", "지코":"zico",
//                 "선미":"sunmi", "보아":"boa", "청하":"chungha", "권은비":"eunbi", "씨엘":"cl", "아이유":"iu", "화사":"hwasa", "제시":"jessi", "현아":"hyuna", "헤이즈":"heize"]


//["블랙핑크", "트와이스", "뉴진스", "르세라핌", "아이브", "케플러", "엔믹스", "잇지", "여자아이들", "클라씨",
//                                      "방탄소년단", "투모로우바이투게더", "스트레이키즈", "엔씨티", "세븐틴", "위너", "빅뱅", "SF9", "갓세븐", "트레저",
//                                      "강다니엘", "지드래곤", "크러쉬", "제이홉", "알엠", "이찬혁", "임영웅", "백현", "카이", "지코",
//                                      "선미", "보아", "청하", "권은비", "씨엘", "아이유", "화사", "제시", "현아", "헤이즈"]
