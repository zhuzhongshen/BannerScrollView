



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
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        if !self.isEqual(nil) {
            
            self.setUP()
            
        }
    }
    func setUP(){
        
        imageV = UIImageView(frame:CGRectZero)
        self.contentView.addSubview(imageV)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageV.frame = self.contentView.bounds
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
