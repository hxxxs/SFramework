//
//  XSTableViewCell.swift
//  XSBase
//
//  Created by 123 on 2019/2/28.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit
import SnapKit
import XSExtension

open class XSTableViewCell: UITableViewCell {
    
    /// 注册并返回一个可重用单元格
    ///
    /// - Parameters:
    ///   - tableView: 注册单元格的tableview
    ///   - style: 单元格样式，默认样式default
    ///   - reuseIdentifier: 注册可重用单元格标示服
    public static func cell(with tableView: UITableView,
                            style: UITableViewCell.CellStyle = .default,
                            reuseIdentifier: String? = nil) -> UITableViewCell {
        let identifier = reuseIdentifier ?? "\(classForCoder())Indentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = XSTableViewCell(style: style, reuseIdentifier: identifier)
        }
        return cell!
    }
    
    /// 分割线
    open var lineView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lineView.backgroundColor = UIColor.lightGray
        contentView.addSubview(lineView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        lineView.backgroundColor = UIColor.lightGray
        contentView.addSubview(lineView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
