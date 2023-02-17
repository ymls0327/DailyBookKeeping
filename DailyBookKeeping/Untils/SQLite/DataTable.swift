//
//  DataTable.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SQLite

class DataTable: NSObject {

    // 表中的字段
    let dataId = Expression<Int64>.init("id")
    let categoryId = Expression<String>.init("category_id")
    let money = Expression<String>.init("money")
    let createTime = Expression<Date>.init("create_time")
    let updateTime = Expression<Date>.init("update_time")
    
    static let share = DataTable()
    var table: Table?
    
    override init() {
        super.init()
        // 初始化表
        table = DBManager.share.createTable(tableName: "data_table") { builder in
            builder.column(dataId, primaryKey: .autoincrement)
            builder.column(categoryId)
            builder.column(money, defaultValue: "0.00")
            builder.column(createTime, defaultValue: Date())
            builder.column(updateTime, defaultValue: Date())
        }
    }
}

extension DataTable {
    // 增加类目
    func add(name: String, block: ((_ error: NSError?) -> ())) {
        let result = DBManager.share.insert(table: table, values: [categoryId <- "2", money <- "345.45"])
        if result {
            block(nil)
        }else {
            block(NSError.init(domain: "", code: -1))
        }
        
    }
    // 获取所有类目
    func getAllCategory() -> [Row]? {
        return DBManager.share.select(table: table)
    }
}
