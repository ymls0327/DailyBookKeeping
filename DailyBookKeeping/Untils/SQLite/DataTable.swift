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
    let categoryId = Expression<Int64>.init("category_id")
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
    @discardableResult func insert(imoney: String, icategory: Int64) -> Bool {
        let result = DBManager.share.insert(table: table, values: [categoryId <- icategory, money <- imoney])
        return result
    }
    
    // 获取所有类目
    func getAllCategory(select: [Expressible] = [], filter: Expression<Bool>? = nil) -> [Row]? {
        return DBManager.share.select(table: table, select: select, filter: filter)
    }
}
