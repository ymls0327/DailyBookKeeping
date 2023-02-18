//
//  HomeViewModel.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit
import SQLite

class HomeViewModel: NSObject {
    
    override init() {
        super.init()
        
    }
    
    // 获取数据
    func requestDatas() -> Array<HomeCategoryItemModel> {
        // 先查出所有的分类
        let categorys = CategoryTable.share.getAllCategory()
        // 根据分类查所有该分类数据的总值
        var array = Array<HomeCategoryItemModel>()
        for item in categorys ?? [] {
            let model = HomeCategoryItemModel()
            model.categoryId = try? item.get(CategoryTable.share.categoryId)
            model.categoryIcon = try? item.get(CategoryTable.share.iconUrl)
            model.categoryName = try? item.get(CategoryTable.share.categoryName)
            model.categoryColor = try? item.get(CategoryTable.share.categoryColor)
            // 查询类目下符合条件的数据
            let datas = DataTable.share.getAllCategory(select: [DataTable.share.money], filter: DataTable.share.categoryId == model.categoryId!)
            var totalMoney = 0.00
            if datas?.count != 0 {
                for data in datas ?? [] {
                    let money = (try? data.get(DataTable.share.money) as NSString)!.floatValue
                    totalMoney += Double(money)
                }
            }
            model.money = NSString.init(format: "%g", totalMoney) as String
            if model.categoryId != nil {
                array.append(model)
            }
        }
        return array
    }
}
