//
//  CategoryTable.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SQLite

class CategoryTable: NSObject {
    // 表中的字段
    let categoryId = Expression<Int64>.init("id")
    let categoryName = Expression<String>.init("category_name")
    let iconUrl = Expression<String?>.init("icon_url")
    let categoryColor = Expression<String?>.init("category_color")
    
    
    static let share = CategoryTable()
    var table: Table?
    
    override init() {
        super.init()
        // 初始化表
        table = DBManager.share.createTable(tableName: "category_table") { builder in
            builder.column(categoryId, primaryKey: .autoincrement)
            builder.column(categoryName, defaultValue: nil)
            builder.column(categoryColor, defaultValue: nil)
            builder.column(iconUrl)
        }
    }
}

extension CategoryTable {
    // 增加类目
    func add(name: String, icon: String, color: String) -> Bool {
        let result = DBManager.share.select(table: table, filter: categoryName == name)
        if result?.count == 0 {
            return DBManager.share.insert(table: table, values: [categoryName <- name, iconUrl <- icon, categoryColor <- color])
        }
        return false
    }
    // 获取所有类目
    func getAllCategory() -> [Row]? {
        return DBManager.share.select(table: table)
    }
    // 删除所有类目
    @discardableResult func deleteAll() -> Bool {
        return DBManager.share.delete(table: table)
    }
}
