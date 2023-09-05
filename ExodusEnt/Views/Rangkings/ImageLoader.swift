//
//  ImageLoader.swift
//  ExodusEnt
//
//  Created by mac on 2023/09/04.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import RxSwift
import Alamofire
import AlamofireImage

func downloadImagesAndPopulateDic(storageRef: StorageReference, limit: Int) -> Observable<[String: UIImage]> {
    return Observable.create { observer in
        var imageDic: [String: UIImage] = [:]

        storageRef.list(maxResults: Int64(limit)) { (result, error) in
            if let error = error {
                observer.onError(error)
                return
            }

            let group = DispatchGroup()

            for item in result!.items {
                group.enter()
                item.downloadURL { (url, error) in
                    if let error = error {
                        observer.onError(error)
                        group.leave()
                        return
                    }

                    if let downloadURL = url {
                        AF.download(downloadURL).responseData { response in
                            defer { group.leave() }

                            switch response.result {
                            case .success(let data):
                                if let image = UIImage(data: data) {
                                    // 이미지 이름을 추출
                                    let imageName = item.name

                                    // 이미지 이름과 UIImage를 딕셔너리에 추가
                                    imageDic[imageName] = image
                                }
                            case .failure(let error):
                                observer.onError(error)
                            }
                        }
                    } else {
                        group.leave()
                    }
                }
            }

            group.notify(queue: .main) {
                // 모든 이미지 다운로드가 완료된 후 호출
                observer.onNext(imageDic)
                observer.onCompleted()
            }
        }

        return Disposables.create()
    }
}

func getMedalImage(forRank rank: Int) -> UIImage? {

    let medalArray = ["gold.svg","silver.svg","bronze.svg"]
    // 1등부터 3등까지의 이미지를 순차적으로 제공.
    if rank >= 1 && rank <= 3 {
        let medalIndex = rank - 1
        if medalIndex < medalArray.count {
            let medalImageName = medalArray[medalIndex]
            return UIImage(named: medalImageName)
        }
    }
    //4등 이후에는 이미지를 제공하지 않음
    return nil
}

class FirebaseDatabaseManager {
    static let shared = FirebaseDatabaseManager()
    
    var rankings: [String: [String: Any]] = [:]
    private var databaseRef: DatabaseReference!

    private init() {
        // Firebase 초기화
      
        
        
        databaseRef = Database.database().reference().child("RangKing") // "RangKing"까지 경로 설정
    }

    func fetchRankings(forCategory category: String, fromRank rankStart: String, toRank rankEnd: String, completion: @escaping ([String: [String: Any]]?) -> Void) {
        let categoryRef = databaseRef.child(category) // "BoySolo"와 같은 카테고리로 이동

        categoryRef.queryOrderedByKey()
            .queryStarting(atValue: rankStart)
            .queryEnding(atValue: rankEnd)
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    var fetchedRankings: [String: [String: Any]] = [:]

                    for rankSnapshot in snapshot.children {
                        if let rankData = rankSnapshot as? DataSnapshot,
                           let rankValue = rankData.value as? [String: Any],
                           let name = rankValue["name"] as? String,
                           let point = rankValue["point"] as? Int {
                            var team: String = ""
                            if let teamValue = rankValue["team"] as? String {
                                team = teamValue
                            }

                            fetchedRankings[rankData.key] = ["name": name, "point": point, "team": team]
                        }
                    }

                    let sortedRankings = fetchedRankings.sorted { lhs, rhs in
                        if let leftPoint = lhs.value["point"] as? Int, let rightPoint = rhs.value["point"] as? Int {
                            if leftPoint == rightPoint {
                                if let leftName = lhs.value["name"] as? String, let rightName = rhs.value["name"] as? String {
                                    return leftName > rightName
                                }
                            }
                            return leftPoint > rightPoint
                        }
                        return false
                    }

                    self.rankings = [:]
                    for (_, (key, value)) in sortedRankings.enumerated() {
                        self.rankings[key] = value
                    }

                    completion(self.rankings)
                } else {
                    completion(nil)
                }
            }
    }
}
