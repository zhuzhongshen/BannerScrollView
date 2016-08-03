



//
//  BannerScrollCollectionViewCell.swift
//  HiMove
//
//  Created by nihao on 16/8/2.
//  Copyright © 2016年 爱淘记. All rights reserved.
//

import UIKit





class BannerScrollCollectionViewCell: UICollectionViewCell {
    
    
    var imageV: UIImageView!
    var titleV:UILabel!
    
    
    var titleHeight:CGFloat = 44{
        
        didSet{
            
        }
        
    }
    
    var titleBackGroudColor : UIColor = UIColor.clearColor(){
        
        didSet{
            
            self.titleV.backgroundColor = titleBackGroudColor
            
        }
        
    }
    
    var titleTextColor:UIColor = UIColor.blackColor(){
        
        didSet{
            
            self.titleV.textColor = titleTextColor
            
        }
    }
    
    var titleFont:UIFont = UIFont.systemFontOfSize(14)
        {
        
        didSet{
            
            self.titleV.font = titleFont
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        if !self.isEqual(nil) {
            
            self.setUP()
            
        }
    }
    func setUP(){
        
        imageV = UIImageView(frame:CGRectZero)
        self.contentView.addSubview(imageV)
        
        titleV = UILabel(frame:CGRectZero)
        self.contentView.addSubview(titleV)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageV.frame = self.contentView.bounds
        
        print("self.titleHeight====\(self.titleHeight)")
        
        titleV.frame = CGRectMake(0, self.bounds.size.height-self.titleHeight, self.bounds.size.width, self.titleHeight)
        titleV.textAlignment = .Center
        print(titleV.frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
