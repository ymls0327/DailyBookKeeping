//
//  HomeCategoryItemModel.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/18.
//

import UIKit
import HandyJSON

class HomeCategoryItemModel: HandyJSON {

    var categoryId: Int64 = 0
    var name: String = ""
    var icon: String = ""
    var color: String = ""
    var money: String = ""
    
    var isAdd: Bool = false
    var isEidt: Bool = false
    
    required init() {}
}
