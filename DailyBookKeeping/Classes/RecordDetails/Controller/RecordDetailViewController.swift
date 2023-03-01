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
        if let model = model {
            cell.icon = model.icon
            cell.category = model.name
        }
        cell.money = dataList[indexPath.row].money
        cell.remark = dataList[indexPath.row].remark
        cell.time = dataList[indexPath.row].createTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "删除", handler: { [weak self] action, view, hanlder in
            if let weakSelf = self, DBManager.share.delete_record_with(id: weakSelf.dataList[indexPath.row].recordId) {
                weakSelf.dataList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .top)
            }else {
                hanlder(false)
            }
        })
        action.backgroundColor = .red_color
        let swipe = UISwipeActionsConfiguration(actions: [action])
        swipe.performsFirstActionWithFullSwipe = false
        return swipe
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            debugPrint("123")
        }
    }
    
    private func lazyTableView() -> UITableView {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .separator_color
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
