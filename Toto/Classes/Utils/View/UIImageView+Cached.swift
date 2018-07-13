//
//  UIImageView+Cached.swift
//  Common
//
//  Created by Nhuan Vu on 2/3/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Downloading and caching images from the web
extension UIImageView {
    
    /// Load image from cached/network with given URL
    ///
    /// - Parameters:
    ///   - url: Image URL
    ///   - placeholder: Placeholder image
    public func setImage(with url: URL, placeholder: UIImage? = nil) {
        kf.setImage(with: url, placeholder: placeholder, options: ImageUtils.imageCachedOptions())
    }
    
    /// Load image from cached/network with given URL string
    ///
    /// - Parameters:
    ///   - urlString: Image URL string
    ///   - placeholder: Placeholder image
    public func setImage(with urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString else {
            image = nil
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        setImage(with: url, placeholder: placeholder)
    }
}
