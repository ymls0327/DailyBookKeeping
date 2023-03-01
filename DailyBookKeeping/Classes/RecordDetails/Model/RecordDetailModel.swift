//
//  RecordDetailModel.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/3/1.
//

import UIKit
import HandyJSON

class RecordDetailModel: HandyJSON {

    var recordId: Int64 = 0
    var money: String = ""
    var remark: String = ""
    var updateTime: String = ""
    var createTime: String = ""
    
    required init() {}
}
