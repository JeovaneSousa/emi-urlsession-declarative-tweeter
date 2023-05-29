//
//  Theme.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 06/12/2022.
//

import UIKit

protocol ThemeConfigurable: UIViewController {
    func applyHomeTheme()
}

extension ThemeConfigurable {
    
    func applyHomeTheme() {
        configureNavigationItem()
        view.backgroundColor = .white
    }
    
    private func configureNavigationItem() {
        let titleView = UIView(frame: .init(origin: .zero,
                                            size: .init(width: view.frame.width, height: 44)))
        titleView.translatesAutoresizingMaskIntoConstraints = false
    
        let containerFrame = CGRect.init(
            origin: titleView.bounds.origin,
            size: .init(width: titleView.bounds.width / 2, height: titleView.bounds.height)
        )
        
        let containerView = UIStackView(arrangedSubviews: [
            buildUserProfileImageView(),
            buildLogoImageView(),
        ])
        containerView.frame = containerFrame
        containerView.axis = .horizontal
        containerView.alignment = .center
        containerView.distribution = .equalCentering
        
        titleView.addSubview(containerView)
        navigationItem.titleView = titleView
    }
    
    fileprivate func buildUserProfileImageView() -> UIImageView {
        let authenticatedUser = UserAuthentication().get()!.user
        
        let imageView = UIImageView()
        imageView.backgroundColor = .quaternaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setImageByDowloading(url: authenticatedUser.profilePictureURL)
        
        let imageSize: CGSize = .init(width: 32, height: 32)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
        ])
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize.width / 2
        return imageView
    }
    
    fileprivate func buildLogoImageView() -> UIImageView {
        let imageView = UIImageView(image: .init(named: "Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let imageSize: CGSize = .init(width: 32, height: 32)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
        ])
        return imageView
    }
    
}

extension UIViewController: ThemeConfigurable {}

