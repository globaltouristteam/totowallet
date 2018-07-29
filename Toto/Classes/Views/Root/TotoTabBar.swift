//
//  TotoTabBar.swift
//  Toto
//
//  Created by Nhuan Vu on 7/29/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit

var showFirstTab: Bool = false

class TotoTabBar: UITabBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateTotoTab()
    }
    
    func updateTotoTab() {
        var buttons = subviews
            .filter({ String(describing: $0).contains("UITabBarButton") })
            .sorted(by: { $0.frame.origin.x < $1.frame.origin.x })
        if !showFirstTab {
            let buttonToHide = buttons.removeFirst()
            var frame = buttonToHide.frame
            frame.origin.x = -200
            buttonToHide.frame = frame
        }
        let totalWidth = buttons.reduce(0, { $0 + $1.frame.size.width })
        let space = (UIScreen.main.bounds.width - totalWidth) / CGFloat(buttons.count)
        
        var calX: CGFloat = space / 2
        for view in buttons {
            var frame = view.frame
            frame.origin.x = calX
            view.frame = frame
            
            calX += frame.width +  space
        }
    }

}
