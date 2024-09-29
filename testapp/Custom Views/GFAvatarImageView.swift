//
//  GFAvatarImageView.swift
//  testapp
//
//  Created by Avaz on 24/09/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder-dark")
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image = placeHolderImage
    }
    
    
    func downloadImage(urlString: String?) {
    
        guard let urlString = urlString else { return }
        
        let cacheKey = NSString(string: urlString) // convert into specific type
        
        // find url in cache
        // if it finds, set cached image inside image
        if let image = cache.object(forKey: cacheKey) {
            self.image = image;
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil { return }
        
            guard let response = response as? HTTPURLResponse,  response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            // after getting image from url
            // save that inside cache
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async  { self.image = image }
            
         };
        
        task.resume()
    }

}
