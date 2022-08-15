//
//  ButtonWithImageAndTitle.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/11.
//

import UIKit

class ButtonWithImageAndTitle: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("Init with coder is unavailable")
    }
    
    private func attribute() {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.imagePadding = 8
        config.imagePlacement = .trailing
        configuration = config
        
        clipsToBounds = true
    }
}
