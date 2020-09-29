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
    private var images = [UIImage]()
    
    private let COUNT = 5
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImages()
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupImages()
        setupButtons()
    }
    
    @objc func buttonTapped(button: UIButton) {
        guard let index = buttons.index(of: button) else {
            return
        }

        let selectedRating = index + 1

        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    private func setupImages() {
        for index in 0..<COUNT {
            let image = UIImage(named: "Beer Rating Images/\(index + 1)")!
            images.append(image)
        }
    }
    
    private func setupButtons() {
        let level0 = UIImage(named: "Beer Rating Images/0")!
        
        for index in 0..<COUNT {
            let button = UIButton()
            
            button.setImage(level0, for: .normal)
            button.setImage(images[index], for: .selected)
        
            button.translatesAutoresizingMaskIntoConstraints = false
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
