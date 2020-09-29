//
//  BeerRatingView.swift
//  beer-app
//
//  Created by Helena Dalmazo on 28/09/20.
//  Copyright © 2020 Helena Dalmazo. All rights reserved.
//

import UIKit

class BeerRatingView: UIStackView {
    
    private var buttons = [UIButton]()
    
    private let count = 5
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc func buttonTapped(button: UIButton) {
        guard let index = buttons.firstIndex(of: button) else {
            return
        }

        let selectedRating = index + 1

        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }

    private func setupButtons() {
        let emptyImage = UIImage(named: "Beer Rating Images/0")!
        
        for index in 0..<count {
            let button = UIButton()
            
            button.setImage(emptyImage, for: .normal)
            
            let imageForIndex = UIImage(named: "Beer Rating Images/\(index + 1)")!
            button.setImage(imageForIndex, for: .selected)
        
//            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            button.addTarget(self, action: #selector(BeerRatingView.buttonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            buttons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in buttons.enumerated() {
            button.isSelected = index < rating
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
