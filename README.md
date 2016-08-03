# BannerScrollView
swift版无限轮播
   
   
        //网络图片路径
        //let images = ["http://s2.mogucdn.com/p1/160720/1030001410_ie4wkyrqgnstszlehezdambqgqyde_640x960.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160529/862717022_ie4wgobtgy4wmmlehazdambqgqyde_640x832.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160711/824082736_ie4gmyzygaztqmdchezdambqgiyde_640x960.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160708/1307592673_ifqwmzjqhe4gmzrzhezdambqgyyde_640x832.jpg_468x468.jpg","http://s2.mogucdn.com/p1/160712/868222168_ifrwiolfgnsgkntchezdambqhayde_640x832.jpg_468x468.jpg"]
        //本地图片
        let localizations = ["localization001.jpg","localization002.jpg","localization003.jpg","localization004.jpg","localization005.jpg"]
        
        banner =  BannerScrollView(frame:CGRectMake(0,0,SCREEN_WIDTH,200))
        //网络图片数据
        //banner.imageGroups = images
        //本地图片数据
        banner.localizationImageNamesGroup = localizations
        //图片模式
        banner.imageContentMode = UIViewContentMode.ScaleAspectFit;
        banner.pageControlAliment = UIControlContentHorizontalAlignment.Left
        //是否自动滚动
        banner.autoScroll = true
        //自动滚动时间
        banner.autoScrollTimeInterval = 1.0
        //UIPageControl.currentPageIndicatorTintColor
        banner.currentPageDotColor = UIColor.whiteColor()
        //UIPageControl.pageIndicatorTintColor
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
   
       //标题
       ...
