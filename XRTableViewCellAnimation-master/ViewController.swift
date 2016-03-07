//
//  ViewController.swift
//  XRTableViewCellAnimation-master
//
//  Created by xuran on 16/3/7.
//  Copyright © 2016年 X.R. All rights reserved.
//

/**
 *  UITableViewCellAnimation 模仿寺库奢侈品App动画
 *  by X.R
 */

import UIKit

extension UIView {
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            self.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            self.height = newValue
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableVw: UITableView!
    var dataArray: [AnyObject]?
    
    func initDataArray() {
        self.dataArray = Array()
        
        for var i = 0; i < 10; i++ {
            let model = CategoryModel()
            model.imageURL = "http://pic18.nipic.com/20120111/6215114_001408692000_2.jpg"
            model.isShowPicture = true
            model.categoryTitle = "腕表"
            self.dataArray?.append(model)
        }
    }
    
    func setupTable() {
        self.tableVw = UITableView(frame: CGRectMake(0, 0, self.view.width, self.view.height), style: .Plain)
        self.tableVw.delegate = self
        self.tableVw.dataSource = self
        self.tableVw.separatorStyle = .None
        self.tableVw.backgroundColor = UIColor.whiteColor()
        self.tableVw.registerClass(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        self.tableVw.tableFooterView = UITableViewHeaderFooterView()
        self.view.addSubview(self.tableVw)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDataArray()
        self.setupTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableVw.dequeueReusableCellWithIdentifier("CategoryCell") as? CategoryCell
        if cell == nil {
            cell = CategoryCell(style: .Default, reuseIdentifier: "CategoryCell")
        }
        
        cell?.selectionStyle = .None
        
        let model = self.dataArray![indexPath.row] as? CategoryModel
        cell?.configCellWithModel(model!)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.dataArray![indexPath.row] as? CategoryModel
        if model!.isShowPicture {
            return 150.0
        }else {
            return 200.0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model = self.dataArray![indexPath.row] as? CategoryModel
        model!.isShowPicture = !model!.isShowPicture
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell
        cell!.cellClickWithModel(model)
        
        // 动态修改cell的高度
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

