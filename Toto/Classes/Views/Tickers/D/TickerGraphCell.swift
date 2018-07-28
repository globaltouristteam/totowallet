//
//  TickerGraphCell.swift
//  Toto
//
//  Created by Nhuan Vu on 7/28/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

protocol TickerGraphCellDelegate: class {
    func didSwitchTo(range: TickerGraphRange)
}

class TickerGraphCell: UITableViewCell {
    weak var delegate: TickerGraphCellDelegate?

    @IBOutlet var btnRange: [UIButton]!

    override func awakeFromNib() {
        super.awakeFromNib()
        for button in btnRange {
            button.layer.cornerRadius = button.frame.height/2
        }
    }

    @IBAction func btnRangeClicked(_ sender: UIButton) {
        guard let index = btnRange.index(of: sender) else { return }
        delegate?.didSwitchTo(range: TickerGraphRange(rawValue: index)!)
    }
    
    func config(with range: TickerGraphRange, data: [Any]) {
        for (index, button) in btnRange.enumerated() {
            if index == range.rawValue {
                button.backgroundColor = Colors.blue
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = nil
                button.setTitleColor(UIColor.darkText, for: .normal)
            }
        }
    }
}
