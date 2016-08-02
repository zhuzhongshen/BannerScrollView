

//
//  BannerScrollView.swift
//  HiMove
//
//  Created by nihao on 16/8/2.
//  Copyright © 2016年 爱淘记. All rights reserved.
//

import UIKit

let CellIdtentifier = "BannerScrollCollectionViewCell"

class BannerScrollView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //1.定义一个闭包类型
    //格式: typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
    typealias bannerBlock = (index:NSInteger) -> Void
    //2. 声明一个变量
    var callBack = bannerBlock?()
    
    var flowLayout:UICollectionViewFlowLayout!
    var mainView:UICollectionView!
    var pageControl:UIPageControl!
    var timer: NSTimer?
    
    var actualItemCount: Int = 0 // 提供
    let imageTimes: Int = 150   // 提供
    //自动滚动时间
    var autoScrollTimeInterval :Double = 2.0{
        didSet{
            if autoScroll {
                self.setupTimer()   //重新设置定时器
            }
        }
    }
    //设置是否自动滚动
    var autoScroll:Bool = false{
        
        didSet{
            self.timer?.invalidate() //先取消先前定时器
            if autoScroll {
                self.setupTimer()   //重新设置定时器
            }
        }
        
    }
    /// 是否开启无限滚动模式,EndlessCycleProtocol提供
    var needEndlessScroll: Bool  = true {
        didSet {
            self.reloadData()
        }
    }
    //图片数据源
    var imageGroups = [NSString](){
        
        didSet{
            
            self.setupPageControl()
            self.reloadData()
        }
        
    }
    //设置对齐方式
    var pageControlAliment:UIControlContentHorizontalAlignment = UIControlContentHorizontalAlignment.Center{
        
        didSet{
            
            self.pageControl.contentHorizontalAlignment = pageControlAliment
            setPageFrame()
        }
    }
    var currentPageDotColor:UIColor = UIColor.whiteColor(){
        
        didSet{
            
            self.pageControl.currentPageIndicatorTintColor = currentPageDotColor
            
        }
        
    }
    var pageDotColor:UIColor = UIColor.lightGrayColor(){
        didSet{
            self.pageControl.pageIndicatorTintColor = pageDotColor
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if !self.isEqual(nil) {
            
            self.setUPMainView()
        }
    }
    func setPageFrame(){
        
        if self.pageControlAliment == UIControlContentHorizontalAlignment.Center{
            
            self.pageControl.frame = CGRectMake(0,  self.bounds.size.height-20, self.width, 20)
        }else if self.pageControlAliment == UIControlContentHorizontalAlignment.Left
        {
            self.pageControl.frame = CGRectMake(10, self.bounds.size.height-20, 100, 20)
        }else{
            self.pageControl.frame = CGRectMake( self.bounds.size.width-100-10,  self.bounds.size.height-20, 100, 20)
        }
    }
    
    
    func setUPMainView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsetsZero
        layout.minimumLineSpacing = 0.0
        //设置横向滚动
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout = layout
        
        
        let collectionV  = UICollectionView(frame:self.bounds, collectionViewLayout: layout)
        //注册一个cell
        collectionV.registerClass(BannerScrollCollectionViewCell.self, forCellWithReuseIdentifier:CellIdtentifier)
        collectionV.delegate = self;
        collectionV.dataSource = self;
        // collectionV.scrollEnabled = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.showsVerticalScrollIndicator = false
        //设置分页
        collectionV.pagingEnabled = true
        collectionV.backgroundColor = UIColor.clearColor()
        collectionV.scrollsToTop = false
        collectionV.bounces = false
        //设置每一个cell的宽高
        layout.itemSize =  self.frame.size
        self.addSubview(collectionV)
        mainView = collectionV
        
    }
    func setupPageControl(){
        
        
        let pageC = UIPageControl()
        pageC.backgroundColor = UIColor.clearColor()
        pageC.numberOfPages = imageGroups.count
        pageC.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageC.currentPageIndicatorTintColor = UIColor.whiteColor()
        self.addSubview(pageC)
        pageC.contentHorizontalAlignment = self.pageControlAliment
        pageC.frame = CGRectMake(0,  self.bounds.size.height-20, self.bounds.size.width, 20)
        pageControl = pageC
        
    }
    /**
     重新加载数据，每当localImageArray或者imageURLArray
     被设置的时候调用
     */
    private func reloadData() {
        
        
        if self.imageGroups.count > 1 {
            self.actualItemCount =  self.needEndlessScroll ? self.imageGroups.count * imageTimes : self.imageGroups.count
        }else {
            self.actualItemCount = 1
        }
        
        //重新加载数据
        self.mainView.reloadData()
        
        if self.autoScroll {
            self.setupTimer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")
    }
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
    }
    
    //pragma mark - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  self.actualItemCount
    }
    //返回自定义的cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdtentifier, forIndexPath: indexPath) as! BannerScrollCollectionViewCell
        let actualItemIndex = indexPath.item % imageGroups.count
        
        let url:NSString = imageGroups[actualItemIndex]
        
        cell.imageV.sd_setImageWithURL(NSURL(string: "\(url)"), placeholderImage: UIImage(named: ""))
        return cell
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (callBack != nil) {
            callBack!(index: indexPath.row)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if self.imageGroups.count>0 {
            let itemIndex:Int = self.currentIndex()
            let indexOnPageControl:Int = itemIndex % self.imageGroups.count
            self.pageControl.currentPage = indexOnPageControl
        }
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if autoScroll == true {
            self.invalidateTimer()
        }
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if  autoScroll == true{
            
            self.setupTimer()
        }
    }
    func setupTimer() -> Void{
        self.timer?.invalidate() //先取消先前定时器
        
        let time = NSTimer.scheduledTimerWithTimeInterval(autoScrollTimeInterval, target: self, selector: #selector(BannerScrollView.automaticScroll), userInfo: nil, repeats: true)
        self.timer = time
        NSRunLoop.mainRunLoop().addTimer(time, forMode: NSRunLoopCommonModes)
    }
    //定时器自动滚动
    func automaticScroll(){

        
        if 0 == self.actualItemCount{
            
        }else
        {
            let currentIndex:Int = self.currentIndex()
            var targetIndex:Int = currentIndex+1
            if targetIndex>=self.actualItemCount {
                targetIndex = Int(Double(self.actualItemCount) * 0.5);
                self.mainView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: targetIndex, inSection: 0), atScrollPosition: .None, animated: true)
            }
            self.mainView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: targetIndex, inSection: 0), atScrollPosition: .None, animated: true)
        }
    }
    //销毁定时器
    func invalidateTimer() ->Void
    {
        self.timer!.invalidate()
        self.timer = nil
        
    }
    //当前页数
    func currentIndex() ->Int{
        
        var index:Int = 0
        
        if (flowLayout.scrollDirection == UICollectionViewScrollDirection.Horizontal)  {
            index = Int((mainView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width)
        }else
        {
            index = Int((mainView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height);
        }
        
        return max(0, index);
    }
    
    
    //    #pragma mark - UIScrollViewDelegate
    
    //3. 定义一个方法,方法的参数为和swiftBlock类型一致的闭包,并赋值给callBack
    func callBackBlock(block : (index:NSInteger) -> Void ){
        callBack = block
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
