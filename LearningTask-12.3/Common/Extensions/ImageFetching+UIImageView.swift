//
//  ImageFetching+UIImageView.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 06/12/2022.
//

import UIKit

extension UIImageView {
    
    func setImageByDowloading(url: URL,
                              using imageDowload: ImageDowload = .init(),
                              placeholderImage: UIImage? = nil) {
        self.image = placeholderImage
        
        imageDowload.execute(for: url) { [weak self] loadedImage, downloadMetada, error in
            if let error = error {
                debugPrint(error)
                return
            }

            guard let loadedImage = loadedImage,
                  let downloadMetada = downloadMetada else {
                debugPrint("Could not possible to load the image")
                return
            }
                
            self?.set(loadedImage, animated: !downloadMetada.fromCache)
        }
    }
    
    private func set(_ image: UIImage, animated: Bool) {
        guard animated else {
            self.image = image
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.layoutIfNeeded()
            
        }) { _ in
            UIView.animate(withDuration: 0.7, delay: 0.2, animations: {
                self.image = image
                
                self.alpha = 1
                self.layoutIfNeeded()
           })
        }
    }
    
}
