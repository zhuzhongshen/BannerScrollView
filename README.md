# BannerScrollView
swift版无限轮播
//网络路径图片轮播
     let images = ["http://s2.mogucdn.com/p1/160720/1030001410_ie4wkyrqgnstszlehezdambqgqyde_640x960.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160529/862717022_ie4wgobtgy4wmmlehazdambqgqyde_640x832.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160711/824082736_ie4gmyzygaztqmdchezdambqgiyde_640x960.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160708/1307592673_ifqwmzjqhe4gmzrzhezdambqgyyde_640x832.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160712/868222168_ifrwiolfgnsgkntchezdambqhayde_640x832.jpg_468x468.jpg"]
        
        self.view.backgroundColor = UIColor.whiteColor()
        banner =  BannerScrollView(frame:CGRectMake(0,0,SCREEN_WIDTH,200))
        banner.imageGroups = images
        banner.pageControlAliment = UIControlContentHorizontalAlignment.Left
        banner.autoScroll = true
        banner.autoScrollTimeInterval = 1.0
        banner.currentPageDotColor = UIColor.whiteColor()
        banner.pageDotColor = UIColor.lightGrayColor()
        self.view.addSubview(banner)
        //代理 需实现 BannerScrollViewDelegate
          banner.delegate = self
        
        /* 闭包实现点击
        banner.callBackBlock { (index) in
            print(index)
        }
        */
      //代理方法实现  
       func bannerClickIndex(index: Int) {
        
        print(index)
      }
    
        
        //本地图片
       ....
       //标题
       ...
