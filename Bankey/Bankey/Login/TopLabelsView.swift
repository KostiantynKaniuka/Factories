//
//  TopLabelsView.swift
//  Bankey
//
//  Created by Kostiantyn Kaniuka on 28.10.2022.
//

import UIKit

class TopLabelsView: UIView {
    
    let bankeyLabel = UILabel()
    let midLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 200)
    }
}

extension TopLabelsView {
    
    private func style() {
        bankeyLabel.translatesAutoresizingMaskIntoConstraints = false
        bankeyLabel.textAlignment = .center
        bankeyLabel.numberOfLines = 0
        bankeyLabel.text = "Bankey"
        bankeyLabel.font = UIFont.boldSystemFont(ofSize: 32)
        bankeyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        midLabel.translatesAutoresizingMaskIntoConstraints = false
        midLabel.translatesAutoresizingMaskIntoConstraints = false
        midLabel.textAlignment = .center
        midLabel.numberOfLines = 0
        midLabel.text = "Your premium source for all things banking"
        midLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(bankeyLabel)
        addSubview(midLabel)
        
        //Mid label
        NSLayoutConstraint.activate([
            midLabel.topAnchor.constraint(equalToSystemSpacingBelow: bankeyLabel.bottomAnchor, multiplier: 3),
            midLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3),
            trailingAnchor.constraint(equalToSystemSpacingAfter: midLabel.trailingAnchor, multiplier: 3)
            
        ])
        
        // Bankey label
        NSLayoutConstraint.activate([
            bankeyLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: bankeyLabel.trailingAnchor, multiplier: 1),
            bankeyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

