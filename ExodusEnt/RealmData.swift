//
//  RealmData.swift
//  ExodusEnt
//
//  Created by mac on 2023/08/21.
//

import Foundation
import RealmSwift

class Profile: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String?
    @Persisted var bestIdol: String?
    @Persisted var birth: String?
    @Persisted var gender: String?
    @Persisted var country: String?
    @Persisted var time: String?
    @Persisted var time_2: String?
    @Persisted var time_3: String?
    @Persisted var time_4: String?
    @Persisted var email: String?
    @Persisted var code: String?
    
    override static func primaryKey() -> String? {
            return "id"
    }
}


