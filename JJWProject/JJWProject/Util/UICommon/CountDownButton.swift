//
//  CountDownButton.swift
//  JJWProject
//
//  Created by 123 on 2019/3/20.
//  Copyright © 2019 hxs. All rights reserved.
//  内部带倒计时逻辑的按钮

import UIKit

class CountDownButton: UIButton {

    private var timer: Timer?
    var countDownTimeInterval: Int = 60
    var finshTitle: String = "重新获取"
    var changeTitle: String = "s后重新获取"
    
    deinit {
        print("\(classForCoder)" + " 释放")
    }
    
    override func removeFromSuperview() {
        stopCountdown()
        super.removeFromSuperview()
    }
    
    // MARK: - Timer
    
    /// 倒计时
    @objc private func countDown() {
        countDownTimeInterval -= 1
        if countDownTimeInterval == 0 {
            stopCountdown()
        } else {
            setTitle("\(countDownTimeInterval)" + changeTitle, for: .normal)
        }
    }
    
    /// 开始倒计时
    func startCountdown(second: Int = 60) {
        timer?.invalidate()
        countDownTimeInterval = second
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        timer?.fire()
        isUserInteractionEnabled = false
    }
    
    /// 倒计时结束
    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        setTitle(finshTitle, for: .normal)
        isUserInteractionEnabled = true
    }

}
