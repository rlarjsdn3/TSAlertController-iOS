//
//  MargetCaplitalizationView.swift
//  TSAlertController_Example
//
//  Created by 김건우 on 2/11/25.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

final class MarketCapView: UIView {
    
    // MARK: - Properties
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(dateLabel)
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Capitalization"
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "As of February 3rd, US Time"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 15
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formulaLabel)
        return view
    }()

    private let formulaLabel: UILabel = {
        let label = UILabel()
        label.text = "Stock Price × Shares Outstanding"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Market capitalization represents the total value of a company's stock. It helps compare the size of companies in the stock market."
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Intializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 230)
        ])
        
        addSubview(labelStack)
        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            labelStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        
        addSubview(background)
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalToConstant: 60),
            background.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 30),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            formulaLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            formulaLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor)
        ])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            descriptionLabel.topAnchor.constraint(equalTo: background.bottomAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
