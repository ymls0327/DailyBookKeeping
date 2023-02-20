//
//  HomeViewModel.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit
import SQLite
import HandyJSON

class HomeViewModel: NSObject {
    
    var totalMoney: String?
    var categorys: Array<[String: Any]> = []
    
    override init() {
        super.init()
        
    }
    
    // 获取数据
    func requestDatas() -> Array<HomeCategoryItemModel> {
        // 先查出所有的分类
        categorys = CategoryTable.share.getAllCategory()
        // 根据分类查所有该分类数据的总值
        var array: [HomeCategoryItemModel] = []
        var total = 0.0
        for dictionary in categorys {
            let model = HomeCategoryItemModel.deserialize(from: dictionary, designatedPath: "")!
            // 查询类目下符合条件的数据
            let datas = DataTable.share.selectMoney(with: model.categoryId)
            var totalMoney = 0.0
            for data in datas {
                totalMoney = totalMoney + Double(data)!
            }
            total = total + totalMoney
            model.money = NSString.init(format: "%0.2lf", totalMoney) as String
            array.append(model)
        }
        totalMoney = NSString.init(format: "%0.2lf", total) as String
        return array
    }
}
