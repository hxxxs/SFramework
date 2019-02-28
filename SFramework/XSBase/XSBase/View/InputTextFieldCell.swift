//
//  InputTextFieldCell.swift
//  XSBase
//
//  Created by 123 on 2019/2/28.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit

open class InputTextFieldCell: XSTableViewCell {
    
    open var textField = UITextField()

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
