//
//  RecordDetailViewController.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/3/1.
//

import UIKit

class RecordDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    open var model: HomeCategoryItemModel?
    
    private lazy var tableView: UITableView = lazyTableView()
    
    private var dataList: [RecordDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestDatas()
    }
    
    override func placeSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    private func requestDatas() {
        if let model = model, model.categoryId > 0 {
            let list = DBManager.share.select_record_with(model.categoryId)
            dataList.removeAll()
            for dictionary in list ?? [] {
                if let model = RecordDetailModel.deserialize(from: dictionary) {
                    dataList.append(model)
                }
            }
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecordDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecordDetailTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    private func lazyTableView() -> UITableView {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(RecordDetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        if #available(iOS 11.0, *) {
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.contentInsetAdjustmentBehavior = .never
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0
            }
        }
        return tableView
    }

}
