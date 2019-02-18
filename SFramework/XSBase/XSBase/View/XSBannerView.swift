//
//  XSBannerView.swift
//  XSBase
//
//  Created by 123 on 2019/2/1.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit

open class XSBannerView: UIView {

    /// 时间间隔
    open var timeInterval: TimeInterval = 3
    
    /// 详情数组
    open var infos: [[String: Any]]? {
        didSet {
            pageControl.numberOfPages = oldValue?.count ?? 0
            pageControl.frame = CGRect(x: 0, y: 0, width: 20 * (oldValue?.count ?? 0), height: 20)
            pageControl.center = CGPoint(x: bounds.width / 2, y: bounds.height - 10)
            currentIndex = 0
        }
    }
    
    /// 当前索引
    open var currentIndex: Int! {
        didSet {
            pageControl.currentPage = oldValue
            
            if infos?.count == 0 {
                return
            }
            
            //  计算图片索引
            //            let leftIndex = currentIndex - 1 + infos!.count % infos!.count
            //            let rightIndex = currentIndex + 1 % infos!.count
            //
            //            let leftUrl = infos![leftIndex]["picUrl"]
            //            let centerUrl = infos![oldValue]["picUrl"]
            //            let rightUrl = infos![rightIndex]["picUrl"]
            
            //            [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftUrl]];
            //            [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:centerUrl]];
            //            [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightUrl]];
        }
    }
    
    open lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: bounds)
        //  设置 scrollView
        sv.bounces = false //  回弹效果
        sv.showsVerticalScrollIndicator = false //  隐藏滚动条（垂直）
        sv.showsHorizontalScrollIndicator = false //  隐藏滚动条（水平）
        sv.isPagingEnabled = true //  开启分页
        sv.contentOffset = CGPoint(x: bounds.width, y: 0) //   偏移量
        sv.contentSize = CGSize(width: 3 * bounds.width, height: 0) //  移动范围
        sv.delegate = self
        return sv
    }()
    
    open lazy var leftImageView = UIImageView(frame: bounds)
    open lazy var centerImageView = UIImageView(frame: CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height))
    open lazy var rightImageView = UIImageView(frame: CGRect(x: 2 * bounds.width, y: 0, width: bounds.width, height: bounds.height))
    open lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor.white
        pc.pageIndicatorTintColor = UIColor.darkGray
        return pc
    }()
    
    /// 定时器
    open var timer: Timer?
    
    deinit {
        stopTimer()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configUI()
    }
}

// MARK: - UIScrollViewDelegate
extension XSBannerView: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pauseTimer()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        resumeTimer(timeInterval: timeInterval)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if infos?.count == 0 {
            return
        }
        
        if scrollView.contentOffset.x == 0 {
            currentIndex = (currentIndex - 1 + infos!.count) % infos!.count
        } else if scrollView.contentOffset.x == scrollView.bounds.width * 2 {
            currentIndex = (currentIndex + 1) % infos!.count
        } else {
            return
        }
        
        //  偏移回初始位置
        scrollView.contentOffset = CGPoint(x: bounds.width, y: 0)
    }
}

// MARK: - Timer
extension XSBannerView {
    
    @objc func startLoopScroll() {
        scrollView.setContentOffset(CGPoint(x: bounds.width * 2, y: 0), animated: true)
        perform(#selector(scrollViewDidEndDecelerating(_:)))
    }
    
    func startTimer() {
        if (timer != nil) || infos?.count == 1 {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(startLoopScroll), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        timer?.fireDate = Date.distantFuture
    }
    
    func resumeTimer(timeInterval: TimeInterval) {
        timer?.fireDate = Date(timeIntervalSinceNow: timeInterval)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - UI
extension XSBannerView {
    
    func configUI() {
        addSubview(scrollView)
        scrollView.addSubview(leftImageView)
        scrollView.addSubview(centerImageView)
        scrollView.addSubview(rightImageView)
        addSubview(pageControl)
    }
}

