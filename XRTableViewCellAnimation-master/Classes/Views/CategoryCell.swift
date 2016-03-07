//
//  CategoryCell.swift
//  XRTableViewCellAnimation-master
//
//  Created by xuran on 16/3/7.
//  Copyright © 2016年 X.R. All rights reserved.
//

import UIKit

let animationTime: NSTimeInterval = 0.3

class CategoryCell: UITableViewCell {
    
    var imageVw: UIImageView?
    var backVw : UIView?
    var cateLabel: UILabel?
    var overVw: UIView?
    var topVw:  UIButton?
    var topLabel: UILabel?
    var isShow: Bool = true
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.imageVw = UIImageView()
        self.contentView.addSubview(self.imageVw!)
        
        self.overVw = UIView()
        self.overVw?.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(self.overVw!)
        
        self.backVw = UIView()
        self.backVw?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        self.imageVw?.addSubview(self.backVw!)
        
        self.cateLabel = UILabel()
        self.cateLabel?.font = UIFont.boldSystemFontOfSize(15.0)
        self.cateLabel?.textColor = UIColor.whiteColor()
        self.cateLabel?.textAlignment = NSTextAlignment.Center
        self.imageVw?.addSubview(self.cateLabel!)
        
        self.topVw = UIButton()
        self.topVw?.backgroundColor = UIColor.blackColor()
        self.topLabel = UILabel()
        self.topLabel?.font = UIFont.systemFontOfSize(14.0)
        self.topLabel?.textColor = UIColor.whiteColor()
        self.topLabel?.textAlignment = NSTextAlignment.Center
        self.topVw?.addSubview(self.topLabel!)
        self.overVw?.addSubview(self.topVw!)
        self.overVw?.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageVw?.frame = CGRectMake(0, 0, self.width, self.height)
        self.backVw?.frame = self.imageVw!.frame
        self.cateLabel?.frame = self.backVw!.frame
        
        self.topVw?.frame = CGRectMake(0, 0, self.width, 40)
        self.topLabel?.frame = CGRectMake(0, 0, self.width, self.topVw!.height - 10)
        if self.isShow {
            self.overVw?.frame = CGRectMake(0, self.height * 0.5, self.width, 0.0)
        }else {
            self.overVw?.frame = CGRectMake(0, 0.0, self.width, self.height)
        }
    }
    
    func configCellWithModel(model: CategoryModel?) {
        
        if let cateModel = model {
            self.imageVw?.imageFromURL(cateModel.imageURL!, placeholder: UIImage())
            self.topLabel?.text = "首饰"
            self.cateLabel?.text = cateModel.categoryTitle
            self.isShow = cateModel.isShowPicture
            if cateModel.isShowPicture {
                self.overVw?.frame = CGRectMake(0, self.height * 0.5, self.width, 0)
            }else {
                self.overVw?.frame = CGRectMake(0, 0, self.width, self.height)
            }
        }
    }
    
    func cellClickWithModel(model: CategoryModel?) {
        if let cateModel = model {
            self.isShow = cateModel.isShowPicture
            if cateModel.isShowPicture {
                UIView.animateKeyframesWithDuration(animationTime, delay: 0, options: .CalculationModeLinear, animations: { () -> Void in
                    self.overVw?.frame = CGRectMake(0, self.height * 0.5, self.width, 0.0)
                    }, completion: { (finished) -> Void in
                    self.overVw?.frame = CGRectMake(0, self.height * 0.5, self.width, 0.0)
                })
            }else {
                UIView.animateKeyframesWithDuration(animationTime, delay: 0, options: .CalculationModeLinear, animations: { () -> Void in
                    self.overVw?.frame = CGRectMake(0, 0.0, self.width, self.height)
                    }, completion: { (finished) -> Void in
                    self.overVw?.frame = CGRectMake(0, 0.0, self.width, self.height)
                })
            }
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDidStart(anim: CAAnimation) {
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
    }
}
