//
//  HomeViewModel.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit
import SQLite

class HomeViewModel: NSObject {
    
    var totalMoney: String?
    var widgetList: Array<Dictionary<String, Any>>?
    
    override init() {
        super.init()
        
    }
    
    // 获取数据
    func requestDatas() -> Array<HomeCategoryItemModel> {
        // 先查出所有的分类
        let categorys = CategoryTable.share.getAllCategory()
        // 根据分类查所有该分类数据的总值
        var array = Array<HomeCategoryItemModel>()
        var array1 = Array<Dictionary<String, Any>>()
        var total = 0.0
        var map = Dictionary<String, Any>()
        for item in categorys ?? [] {
            let model = HomeCategoryItemModel()
            model.categoryId = item[CategoryTable.share.categoryId]
            model.categoryIcon = item[CategoryTable.share.iconUrl]
            model.categoryName = item[CategoryTable.share.categoryName]
            model.categoryColor = item[CategoryTable.share.categoryColor]
            map["categoryId"] = NSString.init(format: "%ld", model.categoryId!) as String
            map["categoryIcon"] = model.categoryIcon ?? ""
            map["categoryName"] = model.categoryName ?? ""
            map["categoryColor"] = model.categoryColor ?? ""
            // 查询类目下符合条件的数据
            let datas = DataTable.share.select(select: [DataTable.share.money], filter: DataTable.share.categoryId == model.categoryId!)
            var totalMoney = 0.0
            if datas?.count != 0 {
                for data in datas ?? [] {
                    let money = Float(data[DataTable.share.money])!
                    totalMoney += Double(money)
                    total += Double(money)
                }
            }
            model.money = NSString.init(format: "%0.2lf", totalMoney) as String
            map["money"] = model.money ?? ""
            if model.categoryId != nil {
                array.append(model)
                array1.append(map)
            }
        }
        widgetList = array1
        totalMoney = NSString.init(format: "%0.2lf", total) as String
        return array
    }
}
