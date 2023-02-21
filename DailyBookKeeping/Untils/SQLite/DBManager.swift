//
//  DBManager.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SQLite
import MBProgressHUD
import SwifterSwift

class DBManager: NSObject {

    private let record_table = "record_table"
    private let category_table = "category_table"
    private let current_date = Date().string(withFormat: "YYYY-MM-dd HH:mm:ss")
    private let db_file_path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!+"/dailybook.sqlite"
    
    static let share = DBManager()
    var db: Connection?
    
    func prepare() {
        // 连接数据库
        db = try? Connection(db_file_path)
        db?.busyTimeout = 5.0
        
        // 创建表&索引
        creatTables()
        
        select()
        
//        _ = insert(categoryName: "完2", color: "", icon: "")
    }
}

// MARK: - CRUD
extension DBManager {
    /**
     * 增加一个分类
     */
    func insert(categoryName name: String, color: String, icon: String) -> Bool {
        let sql = """
        INSERT INTO `\(category_table)` (`name`, `color`, `icon`, `create_t`)
        VALUES ('\(name)', '\(color)', '\(icon)', '\(current_date)');
        """
        guard let database = db else { return false }
        do{
            try database.execute(sql)
            return true
        }catch {
            return false
        }
    }
    
    /**
     * 查询
     */
    func select() {
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

// MARK: - 表相关
extension DBManager {
    // 创建数据表
    func creatTables() {
        let sql = """
        CREATE TABLE IF NOT EXISTS `\(record_table)` (
            `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            `money` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
            `category_id` INTEGER NOT NULL ON CONFLICT ROLLBACK DEFAULT 0,
            `create_t` TEXT NOT NULL ON CONFLICT ROLLBACK
        );
        CREATE INDEX IF NOT EXISTS `\(record_table)_index` ON `\(record_table)` (
            `category_id` ASC
        );
        CREATE TABLE IF NOT EXISTS `\(category_table)` (
            `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            `name` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
            `color` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
            `icon` TEXT NOT NULL ON CONFLICT ROLLBACK DEFAULT '',
            `create_t` TEXT NOT NULL ON CONFLICT ROLLBACK
        );
        """
        guard let database = db else { return }
        do{
            try database.execute(sql)
            let hud = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window!!)!, animated: true)
            hud.mode = .text
            hud.label.text = "创建成功"
            hud.minShowTime = 2
            hud.hide(animated: true)
        }catch {
            let hud = MBProgressHUD.showAdded(to: (UIApplication.shared.delegate?.window)!!, animated: true)
            hud.mode = .text
            hud.label.text = error.localizedDescription
            hud.minShowTime = 2
            hud.hide(animated: true)
            debugPrint(error.localizedDescription)
        }
    }
}
