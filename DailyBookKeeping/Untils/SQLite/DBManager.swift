//
//  DBManager.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SQLite

class DBManager: NSObject {

    private let db_file_path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!+"/dailybook.sqlite"
    static let share = DBManager()
    var db: Connection?
    
    func prepare() {
        // 连接数据库
        db = try? Connection(db_file_path)
        db?.busyTimeout = 5.0
        
        let sql =
"""
        CREATE TABLE IF NOT EXISTS `my_table` (
        `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(30)
        )ENGINE=INNODB DEFAULT CHARSET = utf8;
"""
        try? db?.run(sql)
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
    
    // 添加索引
    @discardableResult func createTableIndex(table: Table?, _ columns: Expressible..., unique: Bool = false, ifNotExists: Bool = false) -> Bool {
        do {
            guard let tab = table else { return false }
            for column in columns {
                try db?.run(tab.createIndex(column, unique: unique, ifNotExists: ifNotExists))
            }
            return true
        }catch {
            debugPrint("❌" + error.localizedDescription)
            return false
        }
    }
}

extension DBManager {
    // 增
    @discardableResult func insert(table: Table?, values: [Setter]) -> Bool {
        guard let tab = table else {
            return false
        }
        do {
            try db?.run(tab.insert(values))
            return true
        }catch {
            debugPrint("❌" + error.localizedDescription)
            return false
        }
    }
    // 删
    @discardableResult func delete(table: Table?, filter: Expression<Bool>? = nil) -> Bool {
        guard var tab = table else {
            return false
        }
        do {
            if let filterTemp = filter  {
                tab = tab.filter(filterTemp)
            }
            try db?.run(tab.delete())
            return true
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
    func sum(table: Table?, select: Expression<Int64>) {
        guard let tab = table else {
            return
        }
        do{
            let sum = try db?.scalar(tab.select(select.sum))
            debugPrint(sum)
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    // 查
    func select(table: Table?, select: [Expressible] = [], filter: Expression<Bool>? = nil, order: [Expressible] = [], limit: Int? = nil, offset: Int? = nil) -> [Row]? {
        guard var tab = table else {
            return nil
        }
        do {
            
            let sql = "select * from data_table"
            
            let data = try! db?.execute(sql)
            
            if select.count != 0 {
                tab = tab.select(select).order(order)
            }else {
                tab = tab.order(order)
            }
            if let filterTemp = filter {
                tab = tab.filter(filterTemp)
            }
            if let lim = limit{
                if let off = offset {
                    tab = tab.limit(lim, offset: off)
                }else{
                    tab = tab.limit(lim)
                }
            }
            guard let result = try db?.prepare(tab) else { return nil }
            
            return Array.init(result)
            
        }catch {
            debugPrint("❌" + error.localizedDescription)
            return nil
        }
    }
}
