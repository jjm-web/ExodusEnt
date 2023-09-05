//
//  SoloboyViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/10/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Alamofire
import AlamofireImage
import RxSwift
import RxCocoa

class SoloboyViewController: UIViewController {
   
    @IBOutlet var table: UITableView!
    
    var ref: DatabaseReference!
    let storage = Storage.storage()
    // ranking 딕셔너리
    var boyRankings: [String: [String: Any]] = [:]
    // 이미지 딕셔너리
    var boyImageDic: [String: UIImage] = [:]
 
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //파이어베이스 초기화
        table.delegate = self
        table.dataSource = self
        //테이블 뷰에서 사용할 셀을 등록하는 코드입니다.
        ref = Database.database().reference()
        callFirebase()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func callFirebase() {


        FirebaseDatabaseManager.shared.fetchRankings(forCategory: "BoySolo", fromRank: "Rank_001", toRank: "Rank_010") { rankings in
            if let rankings = rankings {
                // 가져온 데이터를 사용하여 작업 수행
                print("Rankings: \(rankings)")
                self.boyRankings = rankings
                self.downloadImagesAndPopulateDic()
                self.table.reloadData()
    
            } else {
                print("Data not found")
            }
        }
        
    }

    func downloadImagesAndPopulateDic() {
        let storageRef = storage.reference().child("boysoloidol/RankImg")
        ExodusEnt.downloadImagesAndPopulateDic(storageRef: storageRef, limit: 10)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { imageDict in
                // 이미지 다운로드 완료 후 처리
                print("Image download completed")
                print("imageDict: \(imageDict)")
                self.boyImageDic = imageDict
                self.table.reloadData()
                // 여기서 imageDict를 원하는 곳에 저장하거나 처리할 수 있습니다.
            }, onError: { error in
                // 오류 처리
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }



        
// 버튼 액션
//    @IBAction func updateButtonPressed(_ sender: Any) {
//            updateRanking(member: "Member A", newPoint: 110) // 멤버와 포인트 업데이트
//        }
//    }

    
}

extension SoloboyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoySoloTableCell", for: indexPath) as! BoySoloTableCell
        
        // 현재 indexPath의 행 번호가 rankings 딕셔너리의 크기보다 작은지 확인
        if indexPath.row < boyRankings.count {
            // 현재 셀이 랭킹 데이터에 해당하므로 rank 변수를 계산하여 현재 랭킹을 표시
            let rank = indexPath.row + 1
            let ranking = Array(boyRankings.values)[indexPath.row]
            let name = ranking["name"] as? String ?? ""
            let point = ranking["point"] as? Int ?? 0
            let team = ranking["team"] as? String ?? ""
            
            cell.lblLanking?.text = "\(rank)"
            cell.lblSoloName?.text = "\(name)"
            cell.lblPoint.text = "\(point)"
            cell.lblTeam?.text = "\(team)"
            // 메달 이미지 설정
            if let medalImage = getMedalImage(forRank: rank) {
                cell.medalImg?.image = medalImage
            } else {
                cell.medalImg?.image = nil // 4등 이후에는 이미지 뷰를 비운다.
            }
            
            // 이미지 배열에서 이미지 이름을 가져와서 이미지를 설정 (확장자 .jpeg 추가)
            if let imageName = ranking["name"] as? String,
               let image = boyImageDic["\(imageName).jpeg"] {
                cell.idolImg?.image = image
            } else {
                cell.idolImg?.image = nil // 이미지가 없는 경우 이미지 뷰를 비웁니다.
            }
            
            cell.idolImg?.layer.cornerRadius = 10.0
            cell.idolImg?.clipsToBounds = true
    
        } else {
            cell.lblSoloName?.text = "" // 데이터가 없는 셀은 빈 문자열로 표시
            cell.lblTeam?.text = "" // 공백을 표시
            cell.idolImg?.image = nil // 이미지 뷰를 비웁니다.
        }
        
        return cell
    }
}

//extension SoloboyViewController {
//    func updateRanking(member: String, newPoint: Int) {
//        ref.child("BoySolo").observeSingleEvent(of: .value) { snapshot in
//            guard var rankings = snapshot.value as? [String: [String: Any]] else { return }
//
//            // 현재 랭킹에서 해당 뱀버 정보 가져오기
//            guard let currentRank = rankings.first(where: {$0.value["name"] as? String == member }) else {
//                return
//            }
//
//            // 새로운 포인트로 업데이트
//            rankings[currentRank.key]?["point"] = newPoint
//
//            //포인트에 따라 랭킹 재정렬
//            let sortedRankings = rankings.sorted(by: { ($0.value["point"] as? Int ?? 0) > ($1.value["point"] as? Int ?? 0) })
//            var newRankings: [String: [String: Any]] = [:]
//
//            for (index, (_, value)) in sortedRankings.enumerated() {
//                newRankings["Rank_\(index + 1)"] = value
//            }
//
//            rankings = newRankings
//
//            // 업데이트된 랭킹을 데이터베이스에 저장
//            self.ref.child("BoySolo").setValue(rankings)
//
//            // 테이블 뷰 업데이트
//            self.table.reloadData()
//        }
//    }
//}
