//
//  ActionButton.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 07/12/2022.
//

import UIKit

class ActionButton: UIControl {
    
    override var intrinsicContentSize: CGSize {
        return .init(width: .zero,
                     height: DesignConstants.iconSize.height)
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondaryLabel
        

        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(describing: Int.zero)
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: DesignConstants.fontSize)
        return label
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView, label
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = DesignConstants.interItemSpacing
        stackView.isUserInteractionEnabled = false
        
        return stackView
    }()
    
    var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    var count: String? {
        didSet {
            guard let count = count,
                  let numberOfInteractions = Int(count),
                  numberOfInteractions >= 0 else { return }
            
            label.text = count
            label.isHidden = false
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
    
    private func setup() {
        applyTheme()
        
        addSubview(containerView)
        addConstraints()
    }
    
    private func applyTheme() {
        label.isHidden = true
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: DesignConstants.iconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: DesignConstants.iconSize.height),
        ])
        
        
        
    }
}

fileprivate extension ActionButton {
    struct DesignConstants {
        static let iconSize: CGSize = .init(width: 20, height: 20)
        static let fontSize: CGFloat = 14
        static let interItemSpacing: CGFloat = 8
    }
}
