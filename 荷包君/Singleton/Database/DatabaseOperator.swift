//
//  DatabaseOperator.swift
//  荷包君
//
//  Created by elijah tam on 2019/2/8.
//  Copyright © 2019 elijah tam. All rights reserved.
//

import Foundation
import SQLite

/// 資料庫操作
class DatabaseOperator {
    static let singleton = DatabaseOperator()
    private let db: Connection
    let tags: Tags
    let budget: Budget
    
    private init(){
        db = try! Connection("path/to/db.sqlite3")
        self.tags = Tags(db: db)
        self.budget = Budget(db: db)
        tags.build()
        budget.build()
    }
    
}




// 資料表協定
protocol Tables {
    func build()
}


