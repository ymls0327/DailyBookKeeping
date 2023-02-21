//
//  DataManager.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/21.
//

import UIKit
import SQLite

class DataManager: NSObject {

    // 总金额
    var totalMoney: String = ""
    
    // 单例
    static let share = DataManager()
    
    // 维护的数据表
    private var record_table = RecordDataTable()
    private var category_table = CategoryTable()
    
    override init() {
        super.init()
        
    }
    
    // MARK: - Service
    /**
     * 获取分类数据
     * {"categoryId"、"categoryName"、"categoryColor"、"categoryIcon"}
     */
    func getHomeDatas(complete: @escaping ((_ responseData: [String: Any], _ error: NSError?) -> Void)) {
        guard let categorys = category_table.selectaa() else {
            complete(["code": 201, "msg": "data select error", "data": []], NSError(domain: "db error", code: -1))
            return
        }
                
                
        do{
            let sql =
"""
            SELECT A.id, A.category_name, A.category_color, A.icon_url, SUM(B.money) as total_money
            FROM category_table A
            LEFT JOIN data_table B
            ON A.id=B.category_id
            GROUP BY A.id
"""
            for row in try DBManager.share.db!.prepare(sql) {
                
                guard row.count == 5 else { throw NSError.init(domain: "", code: -1)}
                
                
                let map: NSMutableDictionary = [:]
                map["categoryId"] =  row[0] ?? 0
                map["categoryName"] = row[1] ?? ""
                map["categoryColor"]  = row[2] ?? ""
                map["categoryIcon"] = row[3] ?? ""
                if let aa = row[4] {
                    map["categoryMoney"] = String(describing: aa)
                }else {
                    map["categoryMoney"] = ""
                }
                
                debugPrint(map)
                
//                debugPrint("\(categoryId)、\(categoryName)、\(categoryColor)、\(categoryIcon)、\(categoryMoney)")
            }
        }catch {
            debugPrint(error.localizedDescription)
        }
        
        let aa = try? DBManager.share.db?.scalar(category_table.table!.select(category_table.categoryId.sum))
        
        var array: [[String: Any]] = []
        var totalMoney = 0.0
        for category in categorys {
            var dic: [String: Any] = [:]
            dic["id"] = category[category_table.categoryId]
            dic["name"] = category[category_table.categoryName]
            dic["color"] = category[category_table.categoryColor]
            dic["icon"] = category[category_table.iconUrl]
            // 通过分类Id查询相关数据总金额
            if let records = record_table.select(select: [record_table.money], filter: record_table.categoryId == category[category_table.categoryId]) {
                var money = 0.0
                for record in records {
                    money = money + Double(record[record_table.money])!
                }
                dic["money"] = String(format: "%0.2lf", money)
                totalMoney += money
            }
            array.append(dic)
        }
        self.totalMoney = String(format: "%0.2lf", totalMoney)
        complete(["code": 0, "msg": "success", "data": array], nil)
    }
    
    
    /**
     * 添加一条分类
     */
    func addRecord(name: String, icon: String, color: String) {
        category_table.add(name: name, icon: icon, color: color)
    }
}
