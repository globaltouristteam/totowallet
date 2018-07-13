//
//  ImageUtils.swift
//  Core
//
//  Created by Nhuan Vu on 3/20/18.
//  Copyright © 2018 Toto. All rights reserved.
//

import UIKit
import Kingfisher

public typealias DownloadImageHandler = ((_ image: UIImage?, _ error: Error?) -> Void)

public class ImageUtils {
    public class func setupImageCached() {
        ImageCache.default.maxCachePeriodInSecond = 60 * 60 * 24 * 3 // 3 days
    }
    
    public class func imageCachedOptions() -> KingfisherOptionsInfo {
        return [KingfisherOptionsInfoItem.targetCache(ImageCache.default)]
    }
    
    public class func download(with urlString: String, completionHandler: @escaping DownloadImageHandler) {
        guard let url = URL(string: urlString) else { return }
        
        KingfisherManager.shared.retrieveImage(with: url, options: imageCachedOptions(), progressBlock: nil) { (image, error, _, _) in
            completionHandler(image, error)
        }
    }
}
