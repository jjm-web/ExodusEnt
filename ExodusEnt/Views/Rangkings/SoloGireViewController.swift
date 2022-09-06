//
//  SoloGireViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/21.
//

import UIKit

class SoloGireViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var table_2: UITableView!
    
    var soloNameArray = [ "보아", "청하", "씨엘", "권은비", "헤이즈", "화사", "현아", "아이유", "제시", "선미"]
    var soloImgArray  = ["boa.jpeg", "chungha.jpeg","cl.jpeg","eunbi.jpeg", "heize.jpeg","hwasa.jpeg","hyuna.jpeg","iu.jpeg","jessi.jpeg", "sunmi.jpeg"]
    var soloGroupNameArray = ["", "IOI", "2NE1", "IZONE", "", "MAMAMU", "포미닛", "", "", "원더걸스"]
    var medalArray = ["gold.svg","silver.svg","bronze.svg","","","","","","",""]
    var lankingArray = ["1","2","3","4","5","6","7","8","9","10"]
    var pointArray = ["1,000","900","800","700","600","500","400","300","200","100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_2.delegate = self
        table_2.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return soloNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = table_2.dequeueReusableCell(withIdentifier: "GireSoloTableCell") as! GireSoloTableCell
      
        cell.lblGireSolo.text = soloNameArray[indexPath.row]
        cell.lblGroupName.text = soloGroupNameArray[indexPath.row]
        cell.lblLanking.text = lankingArray[indexPath.row]
        cell.medalImg.image = UIImage(named: medalArray[indexPath.row])
        cell.idolImg.image = UIImage(named: soloImgArray[indexPath.row])
        cell.separatorInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
        cell.heartBtn.setImage(UIImage(contentsOfFile: "heart.svg"), for: .normal)
        cell.imgHeart.image = UIImage(named: "heart_fill.svg")
        cell.idolImg.layer.cornerRadius = 8
        cell.lblPoint.text = pointArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

    
    
}
