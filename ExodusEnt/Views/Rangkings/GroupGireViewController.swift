//
//  GroupGireViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/21.
//

import UIKit

class GroupGireViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table_4: UITableView!
    
    var groupNameArray = [ "블랙핑크", "클라씨", "(여자)아이들", "잇지", "아이브", "케플러", "르세라핌", "뉴진스", "엔믹쓰", "트와이스"]
    var groupImgArray  = ["blackpink.jpeg", "classy.jpeg","idle.jpeg","itzy.jpeg", "ive.jpeg","kepler.jpeg","lesserafim.jpeg","newjeans.jpeg","nmixx.jpeg", "twice.jpeg"]
    var medalArray = ["gold.svg","silver.svg","bronze.svg","","","","","","",""]
    var lankingArray = ["1","2","3","4","5","6","7","8","9","10"]
    var pointArray = ["1,000","900","800","700","600","500","400","300","200","100"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_4.delegate = self
        table_4.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return groupNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = table_4.dequeueReusableCell(withIdentifier: "GireGroupTableCell") as! GireGroupTableCell
      
        cell.lblGroupName.text = groupNameArray[indexPath.row]
        cell.lblLanking.text = lankingArray[indexPath.row]
        cell.medalImg.image = UIImage(named: medalArray[indexPath.row])
        cell.idolImg.image = UIImage(named: groupImgArray[indexPath.row])
        cell.separatorInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
        cell.heartButton.setImage(UIImage(contentsOfFile: "heart.svg"), for: .normal)
        cell.imgHeart.image = UIImage(named: "heart_fill.svg")
        cell.idolImg.layer.cornerRadius = 8
        cell.lblPoint.text = pointArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

    
    
}
