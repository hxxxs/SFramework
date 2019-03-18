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
                            reuseIdentifier: String? = nil) -> XSTableViewCell {
        let identifier = reuseIdentifier ?? "\(classForCoder())Indentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? XSTableViewCell
        if cell == nil {
            cell = XSTableViewCell(style: style, reuseIdentifier: identifier)
        }
        return cell!
    }
    
    /// 分割线
    public var lineView = UIView()
    public var isHiddenLineView: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configLineView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configLineView()
    }
    
    open override func layoutSubviews() {
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
        lineView.backgroundColor = UIColor.lightGray
        contentView.addSubview(lineView)
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
