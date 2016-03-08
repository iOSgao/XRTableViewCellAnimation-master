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
    var lastIndexPath: NSIndexPath?
    
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
        lastIndexPath = NSIndexPath(forRow: -1, inSection: 0)
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
        
        if self.lastIndexPath!.row == -1 {
            let currentModel = self.dataArray![indexPath.row] as? CategoryModel
            currentModel!.isShowPicture = !currentModel!.isShowPicture
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell
            cell!.cellClickWithModel(currentModel)
            
            let currentCellRect = tableView.rectForRowAtIndexPath(indexPath)
            
            if tableView.contentOffset.y > currentCellRect.origin.y {
                // 当前cell的可视区域超出了tableView的top
                tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
            }else if tableView.contentOffset.y + tableView.height - currentCellRect.origin.y < cell!.height {
                // 当前cell的可视区域超出了tableView的bottom
                tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
            }
            self.lastIndexPath = indexPath
        }else {
            if self.lastIndexPath!.row != indexPath.row {
                let currentModel = self.dataArray![indexPath.row] as? CategoryModel
                currentModel!.isShowPicture = !currentModel!.isShowPicture
                
                let cell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell
                cell!.cellClickWithModel(currentModel)
                let currentCellRect = tableView.rectForRowAtIndexPath(indexPath)
                
                if tableView.contentOffset.y > currentCellRect.origin.y {
                    // 当前cell的可视区域超出了tableView的top
                    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                }else if tableView.contentOffset.y + tableView.height - currentCellRect.origin.y < cell!.height {
                    // 当前cell的可视区域超出了tableView的bottom
                    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                }
                
                let lastModel = self.dataArray![self.lastIndexPath!.row] as? CategoryModel
                lastModel?.isShowPicture = true
                let lastCell = tableView.cellForRowAtIndexPath(self.lastIndexPath!) as? CategoryCell
                if let last = lastCell {
                    last.cellClickWithModel(lastModel)
                }
                self.lastIndexPath = indexPath
            }else {
                let currentModel = self.dataArray![indexPath.row] as? CategoryModel
                currentModel!.isShowPicture = !currentModel!.isShowPicture
                
                let cell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell
                cell!.cellClickWithModel(currentModel)
                let currentCellRect = tableView.rectForRowAtIndexPath(indexPath)
                print("\(currentCellRect)  \(tableView.contentOffset.y) \(cell!.height)")
                
                if tableView.contentOffset.y > currentCellRect.origin.y {
                    // 当前cell的可视区域超出了tableView的top
                    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                }else if tableView.contentOffset.y + tableView.height - currentCellRect.origin.y < cell!.height {
                    // 当前cell的可视区域超出了tableView的bottom
                    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                }
                self.lastIndexPath = indexPath
            }
        }
        
        // 动态修改cell的高度
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

