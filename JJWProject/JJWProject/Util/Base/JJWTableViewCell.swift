//
//  JJWTableViewCell.swift
//  JJWProject
//
//  Created by 123 on 2019/3/26.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit

class JJWTableViewCell: UITableViewCell {

    /// 分割线
    var lineView = UIView()
    var isHiddenLineView: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configLineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configLineView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isHiddenLineView { return }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(layoutMargins.left)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
            make.width.equalTo(width - layoutMargins.left - layoutMargins.right)
        }
    }
    
    private func configLineView() {
        lineView.backgroundColor = Color_EDEDED
        contentView.addSubview(lineView)
    }
    
}
