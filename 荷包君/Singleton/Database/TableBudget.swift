//
//  TableBudget.swift
//  荷包君
//
//  Created by elijah tam on 2019/3/20.
//  Copyright © 2019 elijah tam. All rights reserved.
//

import Foundation
import SQLite

class Budget: Tables{
    private let tags = Table("tags")
    private let budget = Table("budget")
    private let id = Expression<Int64>("id")
    private let tag_id = Expression<Int64>("tag_id")
    private let db: Connection
    
    init(db: Connection) {
        self.db = db
    }
    
    // protocol
    func build() {
        do{
            let _ = try db.scalar(budget.exists)
        }
        catch{
            try! db.run(budget.create{ t in
                t.column(id, primaryKey: true)
                t.foreignKey(tag_id, references: tags, id, delete: TableBuilder.Dependency.setNull)
            })
        }
    }
}

