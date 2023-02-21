//
//  RecordDataTable.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SQLite

class RecordDataTable: NSObject {

    // 表中的字段
    let dataId = Expression<Int64>.init("id")
    let categoryId = Expression<Int64>.init("category_id")
    let money = Expression<String>.init("money")
    let createTime = Expression<Date>.init("create_time")
    let updateTime = Expression<Date>.init("update_time")
    
    static let share = RecordDataTable()
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
        // 给dataId、categoryId、createTime创建索引
        DBManager.share.createTableIndex(table: table, dataId, categoryId, createTime, ifNotExists: true)
    }
}

extension RecordDataTable {
    // 添加记录
    @discardableResult func insert(imoney: String, icategory: Int64) -> Bool {
        let result = DBManager.share.insert(table: table, values: [categoryId <- icategory, money <- imoney])
        return result
    }
    
    // 查询记录
    func select(select: [Expressible] = [], filter: Expression<Bool>? = nil) -> [Row]? {
        return DBManager.share.select(table: table, select: select, filter: filter)
    }
    
    // 总金额
    func scalar() {
//        let sum = try? DBManager.share.db?.scalar((table?.select(money.))!)
//        debugPrint(sum as Any)
    }
    
    // 查询money
    func selectMoney(with categoryId: Int64?) -> [String] {
        guard let categoryId = categoryId, let rows = DBManager.share.select(table: table, select: [money], filter: self.categoryId == categoryId) else {
            return []
        }
        var moneyList: [String] = []
        do {
            for row in rows {
                let money = try row.get(money)
                if !money.isEmpty {
                    moneyList.append(money)
                }
            }
            return moneyList
        }catch {
            return moneyList
        }
    }
    
    // 删除记录
    @discardableResult func delete(filter: Expression<Bool>? = nil) -> Bool {
        return DBManager.share.delete(table: table, filter: filter)
    }
}
