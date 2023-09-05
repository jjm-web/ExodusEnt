//
//  GroupGireViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/21.
//

import UIKit

class GroupGireViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    
    var soloNameArray = [ "강다니엘", "지드래곤", "크러쉬", "제이홉", "RM", "이찬혁", "임영웅", "백현", "카이", "지코"]
    var soloGroupNameArray = [ "워너원", "빅뱅", "", "방탄소년단", "방탄소년단", "악동뮤지션", "", "EXO", "EXO", "블락비"]
    
    var soloImgArray  = ["blackpink.svg", "blackpink.svg","blackpink.svg", "blackpink.svg","blackpink.svg","blackpink.svg","blackpink.svg","blackpink.svg","blackpink.svg","blackpink.svg"]
    
    var medalArray = ["gold.svg","silver.svg","bronze.svg","","","","","","",""]
    var lankingArray = ["1","2","3","4","5","6","7","8","9","10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return soloNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = table.dequeueReusableCell(withIdentifier: "GireGroupTableCell") as! GireGroupTableCell
      
        cell.lblGireGroup.text = soloNameArray[indexPath.row]
        cell.lblAgency.text = soloGroupNameArray[indexPath.row]
        cell.lblLanking.text = lankingArray[indexPath.row]
        cell.medalImg.image = UIImage(named: medalArray[indexPath.row])
        cell.idolImg.image = UIImage(named: soloImgArray[indexPath.row])
        cell.separatorInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
        cell.heartButton.setImage(UIImage(contentsOfFile: "heart.svg"), for: .normal)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

}

