//
//  CategoryCell.swift
//  XRTableViewCellAnimation-master
//
//  Created by xuran on 16/3/7.
//  Copyright © 2016年 X.R. All rights reserved.
//

import UIKit

let animationTime: NSTimeInterval = 0.4
let productBaseTag: Int = 2000

func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}

class CategoryCell: UITableViewCell {
    
    var imageVw: UIImageView?
    var backVw : UIView?
    var cateLabel: UILabel?
    var overVw: UIView?
    var topBtn:  UIView?
    var topLabel: UILabel?
    var productVw: UIView?
    var isShow: Bool = true
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.imageVw = UIImageView()
        self.imageVw?.clipsToBounds = true
        self.contentView.addSubview(self.imageVw!)
        
        self.overVw = UIView()
        self.overVw?.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(self.overVw!)
        
        self.backVw = UIView()
        self.backVw?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.imageVw?.addSubview(self.backVw!)
        
        self.cateLabel = UILabel()
        self.cateLabel?.font = UIFont.systemFontOfSize(15.0)
        self.cateLabel?.numberOfLines = 0
        self.cateLabel?.textColor = UIColor.whiteColor()
        self.cateLabel?.textAlignment = NSTextAlignment.Center
        self.imageVw?.addSubview(self.cateLabel!)
        
        self.topBtn = UIButton()
        self.topBtn?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.topBtn?.userInteractionEnabled = false
        self.topLabel = UILabel()
        self.topLabel?.font = UIFont.systemFontOfSize(14.0)
        self.topLabel?.textColor = UIColor.whiteColor()
        self.topLabel?.textAlignment = NSTextAlignment.Center
        self.topLabel?.numberOfLines = 0
        
        self.topBtn?.addSubview(self.topLabel!)
        self.overVw?.addSubview(self.topBtn!)
        self.overVw?.layer.masksToBounds = true // 当子视图的frame超出父视图时将不显示, self.overVw.clipToBounds = true
        
        self.productVw = UIView()
        self.productVw?.backgroundColor = UIColor.whiteColor()
        self.overVw?.addSubview(self.productVw!)
        
        // 产品展示
        for var i = 0; i < 9; i++ {
            let proLabel = UILabel()
            proLabel.textColor = RGBColor(117, g: 117, b: 117)
            proLabel.font = UIFont.systemFontOfSize(12.0)
            proLabel.textAlignment = .Center
            proLabel.text = "项饰/吊坠"
            proLabel.tag = productBaseTag + i
            self.productVw?.addSubview(proLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageVw?.frame = CGRectMake(0, 0, self.width, self.height)
        self.backVw?.frame = self.imageVw!.frame
        self.cateLabel?.frame = self.backVw!.frame
        
        self.topBtn?.frame = CGRectMake(0, 0, self.width, 45)
        self.topLabel?.frame = CGRectMake(0, 0, self.width, self.topBtn!.height)
        if self.isShow {
            self.overVw?.frame = CGRectMake(0, self.height * 0.5, self.width, 0.0)
        }else {
            self.overVw?.frame = CGRectMake(0, 0.0, self.width, self.height)
        }
        
        self.productVw?.frame = CGRectMake(0, CGRectGetMaxY(self.topBtn!.frame), self.width, self.height - self.topBtn!.height)
        
        let proWidth = self.productVw!.width / 3.0
        let proHeight: CGFloat = 20.0
        let border: CGFloat    = 0.0
        let topHeight: CGFloat = 20.0
        for var i = 0; i < 9; i++ {
            let proLabel = self.overVw?.viewWithTag(productBaseTag + i)
            proLabel?.frame = CGRectMake(border + (proWidth + border) * CGFloat((Int(i) % 3)), topHeight + (topHeight + proHeight) * CGFloat(Int(i) / 3), proWidth, proHeight)
        }
    }
    
    func configCellWithModel(model: CategoryModel?) {
        
        if let cateModel = model {
            self.imageVw?.imageFromURL(cateModel.imageURL!, placeholder: UIImage())
            self.topLabel?.text = "首饰" + "\n" + "Jewely"
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
