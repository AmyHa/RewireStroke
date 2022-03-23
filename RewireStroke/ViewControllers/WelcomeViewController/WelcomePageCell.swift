//
//  WelcomePageCell.swift
//  RewireStroke
//
//  Created by Amy Ha on 27/09/2020.
//  Copyright © 2020 Amy Ha. All rights reserved.
//

import UIKit

class WelcomePageCell: UICollectionViewCell {
    
    var parentController: WelcomeViewController?
    
    var page: WelcomePage! {
        didSet {
            titleLabel.text = page.title
            bodyLabel.text = page.text
            imageView.image = UIImage(named: page.image)
            
            // Hacky, think of a nicer way to implement
            if let text = bodyLabel.attributedText {
                bodyLabel.midTextColorChange(fullText: text, changeText: "upper limb", Colours.primaryUpperLimb)
            }
            if let text = bodyLabel.attributedText {
                bodyLabel.midTextColorChange(fullText: text, changeText: "lower limb", Colours.primaryLowerLimb)
            }
            if let text = bodyLabel.attributedText {
                bodyLabel.midTextColorChange(fullText: text, changeText: "balance", Colours.primaryBalance)
            }
        }
    }

    let stackView = UIStackView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let blackView = UIView()
    
    func setupUI() {
        blackView.backgroundColor = .black
        titleLabel.text = ""
        titleLabel.font = UIFont(name: Constants.Font.Name.rajdhaniSemiBold, size: 28)
        titleLabel.textColor = Colours.primaryDark
        titleLabel.numberOfLines = -1
        bodyLabel.text = ""
        bodyLabel.font = UIFont(name: Constants.Font.Name.robotoMedium, size: 14)
        bodyLabel.textColor = Colours.primaryDark
        bodyLabel.numberOfLines = -1
        bodyLabel.textAlignment = .center
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(80, after: imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(30, after: titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.setCustomSpacing(30, after: bodyLabel)
        stackView.axis = .vertical
        
        addSubview(blackView)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
        stackView.alignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTitleTap)))
        titleLabel.isUserInteractionEnabled = true
        bodyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBodyTap)))
        bodyLabel.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleBodyTap() {
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        bodyLabel.backgroundColor = .black
        bodyLabel.textColor = .white
    }
    
    @objc func handleTitleTap(gesture: UITapGestureRecognizer) {
        titleLabel.backgroundColor = .black
        titleLabel.textColor = .white
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if location.x < frame.width / 2 {
            reset()
        } else {
            animatePageOut()
        }
    }
    
    fileprivate func animatePageOut() {
        animateLabelOut()
    }

    override func prepareForReuse() {
        reset()
    }
    
    fileprivate func animateLabelOut(up: Bool = true, completion: (() -> ())? = nil) {
        advance()
    }
    
    @objc func advance() {
        self.parentController?.scrollToNext()
    }
    
    fileprivate func reset() {
        imageView.alpha = 1
        imageView.transform = .identity
        titleLabel.transform = .identity
        titleLabel.alpha = 1
        bodyLabel.transform = .identity
        bodyLabel.alpha = 1
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = Colours.primaryDark
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = Colours.primaryDark
    }

}

