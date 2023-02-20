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
    func getAllCategory() -> Array<[String: Any]> {
        guard let rows = DBManager.share.select(table: table) else {
            return []
        }
        var datas: Array<[String: Any]> = []
        do {
            for row in rows {
                var dictionary: [String: Any] = [:]
                dictionary["categoryId"] = try row.get(categoryId)
                dictionary["categoryName"] = try row.get(categoryName)
                dictionary["categoryIcon"] = try row.get(iconUrl)
                dictionary["categoryColor"] = try row.get(categoryColor)
                datas.append(dictionary)
            }
            return datas
        }catch {
            return datas
        }
    }
    // 删除所有类目
    @discardableResult func deleteAll() -> Bool {
        return DBManager.share.delete(table: table)
    }
}
