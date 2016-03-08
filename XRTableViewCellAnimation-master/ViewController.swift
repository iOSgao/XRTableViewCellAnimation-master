//
//  ViewController.swift
//  XRTableViewCellAnimation-master
//
//  Created by xuran on 16/3/7.
//  Copyright © 2016年 X.R. All rights reserved.
//

/**
 *  实现UITableViewCell展开/闭合动画
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
    var ImageCellHeight: CGFloat = 150.0
    
    func initDataArray() {
        self.dataArray = Array()
        
        for var i = 0; i < 10; i++ {
            let model = CategoryModel()
            model.imageURL = "http://attach.scimg.cn/month_1302/19/c5f4b70093e25c4ba861dbd38c33ab15_orig.jpg"
            model.isShowPicture = true
            model.categoryTitle = "首饰" + "\n" + "Jewelry"
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
        lastIndexPath = NSIndexPath(forRow: -9999, inSection: 0)
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
            return ImageCellHeight
        }else {
            return 240.0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.lastIndexPath!.row == -9999 {
            let currentModel = self.dataArray![indexPath.row] as? CategoryModel
            currentModel!.isShowPicture = !currentModel!.isShowPicture
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell
            // 动态修改cell的高度
            tableView.beginUpdates()
            tableView.endUpdates()
            
            let currentCellRect = tableView.rectForRowAtIndexPath(indexPath)
            
            // cell的高度变化后，cell的y没有变化， 所以应该用变化前的cell的高度进行判断
            if currentCellRect.origin.y - tableView.contentOffset.y < ImageCellHeight{
                // 当前cell的可视区域超出了tableView的top
                let delay = 0.1 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                })
            }else if tableView.contentOffset.y + tableView.height - currentCellRect.origin.y <= cell!.height {
                // 当前cell的可视区域超出了tableView的bottom delay以解决cell没法滚动到最底部的bug 详见：http://stackoverflow.com/questions/25686490/ios-8-auto-cell-height-cant-scroll-to-last-row
                let delay = 0.1 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                })
            }
            self.lastIndexPath = indexPath
            cell!.cellClickWithModel(currentModel)
            
            // 动态修正cell的高度
            tableView.beginUpdates()
            tableView.endUpdates()
        }else {
            if self.lastIndexPath!.row != indexPath.row {
                let currentModel = self.dataArray![indexPath.row] as? CategoryModel
                currentModel!.isShowPicture = !currentModel!.isShowPicture
                // 动态修改cell的高度
                tableView.beginUpdates()
                tableView.endUpdates()
                let cell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell
                let currentCellRect = tableView.rectForRowAtIndexPath(indexPath)
                
                if currentCellRect.origin.y - tableView.contentOffset.y < ImageCellHeight {
                    // 当前cell的可视区域超出了tableView的top
                    let delay = 0.1 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                    })
                }else if tableView.contentOffset.y + tableView.height - currentCellRect.origin.y <= cell!.height {
                    // 当前cell的可视区域超出了tableView的bottom delay以解决cell没法滚动到最底部的bug 详见：http://stackoverflow.com/questions/25686490/ios-8-auto-cell-height-cant-scroll-to-last-row
                    let delay = 0.1 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                    })
                }
                cell!.cellClickWithModel(currentModel)
                
                let lastModel = self.dataArray![self.lastIndexPath!.row] as? CategoryModel
                lastModel?.isShowPicture = true
                let lastCell = tableView.cellForRowAtIndexPath(self.lastIndexPath!) as? CategoryCell
                if let last = lastCell {
                    last.cellClickWithModel(lastModel)
                }
                self.lastIndexPath = indexPath
                // 动态修正cell的高度
                tableView.beginUpdates()
                tableView.endUpdates()
                
            }else {
                let currentModel = self.dataArray![indexPath.row] as? CategoryModel
                currentModel!.isShowPicture = !currentModel!.isShowPicture
                // 动态修改cell的高度
                tableView.beginUpdates()
                tableView.endUpdates()
                let cell = tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell
                // 滚动tableView 到 top 或者 bottom
                let currentCellRect = tableView.rectForRowAtIndexPath(indexPath)
                
                if currentCellRect.origin.y - tableView.contentOffset.y < ImageCellHeight {
                    // 当前cell的可视区域超出了tableView的top
                    let delay = 0.1 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                    })
                }else if tableView.contentOffset.y + tableView.height - currentCellRect.origin.y <= cell!.height {
                    // 当前cell的可视区域超出了tableView的bottom delay以解决cell没法滚动到最底部的bug 详见：http://stackoverflow.com/questions/25686490/ios-8-auto-cell-height-cant-scroll-to-last-row
                    let delay = 0.1 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                    })
                }
                
                cell!.cellClickWithModel(currentModel)
                
                self.lastIndexPath = indexPath
                // 动态修正cell的高度
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }
}

