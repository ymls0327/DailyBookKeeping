//
//  DBManager.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SQLite

class DBManager: NSObject {

    static let share = DBManager()
    private var db: Connection?
    
    func prepare() {
        let db_file_path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!+"/dailybook.sqlite"
        // 连接数据库
        db = try? Connection(db_file_path)
        db?.busyTimeout = 5.0
    }
}

extension DBManager {
    
    // 创建表
    func createTable(tableName: String, block: (TableBuilder) -> Void) -> Table? {
        do{
            let table = Table.init(tableName)
            try db?.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                block(builder)
            }))
            return table
        }catch(let error){
            debugPrint("❌" + error.localizedDescription)
            return nil
        }
    }
    
    // 修改表
    
}

extension DBManager {
    // 增
    func insert(table: Table?, values: [Setter]) -> Bool {
        guard let t = table else {
            return false
        }
        do {
            try db?.run(t.insert(values))
            return true
        }catch {
            debugPrint("❌" + error.localizedDescription)
            return false
        }
    }
    // 删
    
    // 查
    func select(table: Table?, select: [Expressible] = [], filter: Expression<Bool>? = nil, order: [Expressible] = [], limit: Int? = nil, offset: Int? = nil) -> [Row]? {
        guard var queryTable = table else {
            return nil
        }
        do {
            if select.count != 0 {
                queryTable = queryTable.select(select).order(order)
            }else {
                queryTable = queryTable.order(order)
            }
            if let filterTemp = filter {
                queryTable = queryTable.filter(filterTemp)
            }
            if let lim = limit{
                if let off = offset {
                    queryTable = queryTable.limit(lim, offset: off)
                }else{
                    queryTable = queryTable.limit(lim)
                }
            }
            guard let result = try db?.prepare(queryTable) else { return nil }
            
            return Array.init(result)
            
        }catch {
            debugPrint("❌" + error.localizedDescription)
            return nil
        }
    }
}
