//
//  BeerColorSlider.swift
//  beer-app
//
//  Created by Helena Dalmazo on 06/10/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit

class BeerColorSlider: UISlider {
    
    var color: UIColor = UIColor.white {
        didSet {
            colorDidChange()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func colorDidChange() {
        value = Float(UIColor.beerColor(of: color))
    }
    
    @objc func valueDidChange(slider: UISlider) {
        color = UIColor.beerColor(at: Int(value))
    }
    
    private func setup() {
        maximumValue = Float(UIColor.beerColorList.count - 1)
        addTarget(self, action: #selector(BeerColorSlider.valueDidChange(slider:)), for: .valueChanged)
        colorDidChange()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
