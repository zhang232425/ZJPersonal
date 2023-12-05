//
//  UIImageView+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import SDWebImage

extension UIImageView {
    
    @discardableResult
    func imaged(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    @discardableResult
    func highlightImaged(_ image: UIImage?) -> Self {
        self.highlightedImage = image
        return self
    }
    
}

extension UIImageView {
    
    typealias LoadImageResult = Swift.Result<UIImage, Error>
    
    func setImage(with url: String?, placeholder: UIImage?, result: ((LoadImageResult) -> Void)? = nil) {
        
        let imageURL: URL?
        
        if let remoteUrl = url {
            imageURL = URL(string: remoteUrl)
        } else {
            imageURL = nil
        }
        
        let options: SDWebImageOptions = [.retryFailed, .refreshCached]
        
        sd_setImage(with: imageURL, placeholderImage: placeholder, options: options) { (img, err, _, _) in
            if let error = err as NSError?, error.code != SDWebImageError.cancelled.rawValue {
                result?(.failure(error))
            } else if let image = img {
                result?(.success(image))
            }
        }
    }
}

