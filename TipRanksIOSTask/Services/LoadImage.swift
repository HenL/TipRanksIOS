//
//  LoadImage.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 09/08/2021.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    
    func setImage(withUrl url: URL?, imageView: UIImageView) {
        imageView.image = nil
        guard let `url` = url else {
            return
        }
        
        // load cached image
        let key = url.absoluteString as NSString
        if let cachedImage = cache.object(forKey: key) {
            imageView.image = cachedImage
            return
        }
        
        // download image
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak imageView] in
                        imageView?.image = image
                    }
                    self.cache.setObject(image, forKey: key)
                }
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
