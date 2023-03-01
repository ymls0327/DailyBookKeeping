//
//  DBManager.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SQLite
import MBProgressHUD
import HandyJSON
import SwifterSwift

class DBManager: NSObject {

    private let record_table = "record_table"
    private let category_table = "category_table"
    private let label_table = "label_table"
    private let current_date = Date().string(withFormat: "YYYY-MM-dd HH:mm:ss")
    private let db_file_path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!+"/dailybook.sqlite"
    
    static let share = DBManager()
    var db: Connection?
    
    func prepare() {
        // 连接数据库
        db = try? Connection(db_file_path)
        db?.busyTimeout = 5.0
        
        debugPrint(db_file_path)
        
        // 创建表&索引
        creatTables()
    }
    
    private func notification() {
        NotificationCenter.default.post(name: Notification.Name("kDataBaseDidChangedNotification"), object: nil)
    }
}

// MARK: - CRUD - 分类
extension DBManager {
    /**
     * 增加一个分类
     */
    func insert_into_category_table_with(name: String, color: String, icon: String) -> Bool {
        let sql = """
        INSERT INTO `\(category_table)` (`name`, `color`, `icon`, `create_t`)
        VALUES ('\(name)', '\(color)', '\(icon)', '\(current_date)');
        """
        guard let database = db else { return false }
        do{
            try database.execute(sql)
            notification()
            return true
        }catch {
            return false
        }
    }
    
    /**
     * 查询某一条记录是否存在
     */
    private func select_category_with(id: Int64) -> Bool {
        let sql = """
        SELECT * FROM `\(category_table)`  WHERE `id` = \(id);
        """
        guard let database = db else { return false }
        do{
            let result = try database.prepare(sql)
            var count = 0;
            for _ in result {
                count += 1;
            }
            return count > 0
        }catch {
            return false
        }
    }
    
    /**
     * 修改分类
     */
    func update_into_category_table_with(name: String = "", color: String = "", icon: String = "", id: Int64) -> Bool {
        
        var expression: String = ""
        if !name.isEmpty { expression += "`name` = '\(name)'," }
        if !color.isEmpty { expression += "`color` = '\(color)'," }
        if !icon.isEmpty { expression += "`icon` = '\(icon)'," }
        expression += "`update_t` = '\(current_date)'"
        
        let sql = """
        UPDATE \(category_table)
        SET \(expression)
        WHERE `id` = \(id);
        """
        guard let database = db else { return false }
        do{
            try database.execute(sql)
            notification()
            return true
        }catch {
            return false
        }
    }
    
    /**
     * 修改+增加
     */
    func update_insert_into_category_table_with(id: Int64?, name: String, color: String, icon: String) -> Bool {
        // 先查，如果查到，则进行修改，否则添加
        if let id = id, id > 0, select_category_with(id: id) {
            return update_into_category_table_with(name: name, color: color, icon: icon, id: id)
        }
        return insert_into_category_table_with(name: name, color: color, icon: icon)
    }
    
    /**
     * 删除一条记录
     */
    func delete_category_with(id: Int64) -> Bool {
        let sql = """
        DELETE FROM \(category_table)
        WHERE id=\(id);
        """
        guard let database = db else { return false }
        do{
            try database.execute(sql)
            notification()
            return true
        }catch {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
    /**
     * 查询所有分类
     */
    func select_all_category_from_table() {
        let sql = """
        SELECT * FROM `\(category_table)`;
        """
        guard let database = db else { return }
        do{
            for row in try database.prepare(sql) {
                debugPrint(row)
            }
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
}

// MARK: - CRUD - 记录
extension DBManager {
    /**
     * 添加一条记录
     */
    func insert_into_data_table_with(categoryId: Int64, money: String, remark: String) -> Bool {
        if select_category_with(id: categoryId) {
            let sql = """
            INSERT INTO `\(record_table)` (`money`, `category_id`, `remark`, `create_t`)
            VALUES ('\(money)', '\(categoryId)', '\(remark)', '\(current_date)');
            """
            guard let database = db else { return false }
            do{
                try database.execute(sql)
                notification()
                return true
            }catch {
                debugPrint(error.localizedDescription)
                return false
            }
        }else {
            return false
        }
    }
    
    /**
     * 查询某一条记录是否存在
     */
    private func select_record_with(id: Int64) -> Bool {
        let sql = """
        SELECT * FROM `\(record_table)`  WHERE `id` = \(id);
        """
        guard let database = db else { return false }
        do{
            let result = try database.prepare(sql)
            var count = 0;
            for _ in result {
                count += 1;
            }
            return count > 0
        }catch {
            return false
        }
    }
    
    /**
     * 删除一条记录
     */
    func delete_record_with(id: Int64) -> Bool {
        if select_record_with(id: id) {
            let sql = """
            DELETE FROM `\(record_table)` WHERE `id` = \(id);
            """
            guard let database = db else { return false }
            do{
                try database.execute(sql)
                notification()
                return true
            }catch {
                debugPrint(error.localizedDescription)
                return false
            }
        }else {
            return false
        }
    }
}

// MARK: - 常用语
extension DBManager {
    
    // 添加一条常用语
    func insert_into_label_tabel_with(label: String?, category_id: Int64) -> Bool {
        guard let database = db, let label = label, !label.isEmpty, category_id > 0 else { return false }
        
        let sql1 = """
        SELECT * FROM `\(label_table)` WHERE `label` = '\(label)';
        """
        
        let sql2 = """
        INSERT INTO `\(label_table)` (`label`, `category_id`, `create_t`)
        VALUES ('\(label)', \(category_id), '\(current_date)')
        """
        
        do {
            let result = try database.prepare(sql1)
            var count = 0
            for _ in result {
                count += 1
            }
            if count == 0 {
                try database.execute(sql2)
            }
            return true
        }catch {
            return false
        }
    }
}

// MARK: - 业务
extension DBManager {
    // 获取首页数据
    func request_home_datas() -> [String: Any]? {
        
        guard let database = db else { return nil }
        
        let sql1 = "SELECT SUM(money) AS total_money FROM `\(record_table)`;"
        
        let sql2 = """
                SELECT category.id, category.name, category.color, category.icon, SUM(record.money)
                FROM `\(category_table)` AS category
                LEFT JOIN `\(record_table)` as record
                ON category.id=record.category_id
                GROUP BY category.id;
        """
        
        do{
            // 总金额
            var total_money = "0"
            for row in try database.prepare(sql1) {
                if let total = row[0], let double_total = Double(String(describing: total)) {
                    total_money = String(format: "%0.2lf", double_total)
                }
            }
            
            var list: [[String: String]] = []
            for row in try database.prepare(sql2) {
                if let categoryId = row[0] {
                    var map: [String: String] = [:]
                    map["categoryId"] = String(describing: categoryId)
                    if let name = row[1] {
                        map["name"] = String(describing: name)
                    }
                    if let color = row[2] {
                        map["color"] = String(describing: color)
                    }
                    if let icon = row[3] {
                        map["icon"] = String(describing: icon)
                    }
                    if let money = row[4] {
                        if let double_money = Double(String(describing: money)) {
                            map["money"] = String(format: "%0.2lf", double_money)
                        }
                    }
                    list.append(map)
                }
            }
            return ["totalMoney": total_money, "list": list]
        }catch {
            return nil
        }
    }
    
    // 查询分类下的常用语
    func request_category_labels_with(categoryId: Int64) -> [String]? {
        guard let database = db else { return nil }
        
        let sql = """
                SELECT label FROM `\(label_table)` WHERE `category_id` = \(categoryId);
        """
        do {
            var list: [String] = []
            for row in try database.prepare(sql) {
                if let label = row[0] {
                    list.append(String(describing: label))
                }
            }
            return list
        }catch {
            return nil
        }
    }
    
    // 查询某一分类下面的所有数据
    func select_record_with(_ categoryId: Int64) -> [[String: String]]? {
        guard let database = db else { return nil }
        
        let sql = """
        SELECT id, money, remark, update_t, create_t
        FROM `\(record_table)`
        WHERE category_id = \(categoryId)
        ORDER BY `create_t` DESC;
        """
        do {
            var list: [[String: String]] = []
            for row in try database.prepare(sql) {
                if let recordId = row[0] {
                    var map: [String: String] = [:]
                    map["recordId"] = String(describing: recordId)
                    if let money = row[1] {
                        if let double_money = Double(String(describing: money)) {
                            map["money"] = String(format: "%0.2lf", double_money)
                        }
                    }
                    if let remark = row[2] {
                        map["remark"] = String(describing: remark)
                    }
                    if let updateTime = row[3] {
                        map["updateTime"] = String(describing: updateTime)
                    }
                    if let createTime = row[4] {
                        map["createTime"] = String(describing: createTime)
                    }
                    list.append(map)
                }
            }
            return list
        }catch {
            return nil
        }
    }
}

// MARK: - 表相关
extension DBManager {
    // 创建数据表
    func creatTables() {
        let sql = """
                CREATE TABLE IF NOT EXISTS `\(category_table)` (
                    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                    `name` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `color` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `icon` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `update_t` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `create_t` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT ''
                );
                CREATE INDEX IF NOT EXISTS `\(category_table)_index` ON `\(category_table)` (
                    `id` ASC
                );
                CREATE TABLE IF NOT EXISTS `\(record_table)` (
                    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                    `money` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `category_id` INTEGER NOT NULL ON CONFLICT ROLLBACK DEFAULT 0,
                    `remark` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `update_t` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `create_t` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT ''
                );
                CREATE INDEX IF NOT EXISTS `\(record_table)_index` ON `\(record_table)` (
                    `category_id` ASC
                );
                CREATE TABLE IF NOT EXISTS `\(label_table)` (
                    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                    `label` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `category_id` INTEGER NOT NULL ON CONFLICT ROLLBACK DEFAULT 0,
                    `update_t` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
                    `create_t` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT ''
                );
                CREATE INDEX IF NOT EXISTS `\(label_table)_index` ON `\(label_table)` (
                    `category_id` ASC
                );
        """
        
        guard let database = db else { return }
        do{
            try database.execute(sql)
        }catch {
            DBProgressHUD.show(message: error.localizedDescription)
        }
    }
}
