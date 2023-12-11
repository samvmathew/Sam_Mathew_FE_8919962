//
//  BottomBarView.swift
//  Sam_Mathew_FE_8919962
//
//  Created by Sam Mathew on 2023-12-09.
//

import UIKit

class BottomBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

        lazy var button1: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Button 1", for: .normal)
            button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
            return button
        }()

        lazy var button2: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Button 2", for: .normal)
            button.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
            return button
        }()

        lazy var button3: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Button 3", for: .normal)
            button.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
            return button
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupButtons()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupButtons()
        }

        private func setupButtons() {
            let stackView = UIStackView(arrangedSubviews: [button1, button2, button3])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = 8

            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        @objc private func button1Tapped() {
            // Handle button 1 tap
        }

        @objc private func button2Tapped() {
            // Handle button 2 tap
        }

        @objc private func button3Tapped() {
            // Handle button 3 tap
        }
    }
    
    

