//
//  ViewController.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 27.10.2020.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imageForDownload: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        imageForDownload.isHidden = true
        activityIndicator.startAnimating()
        downloadImage()
    }
    
    func downloadImage() {
        guard let url = URL(string:"https://upload.wikimedia.org/wikipedia/commons/4/42/Blue_sky%2C_white-gray_clouds.JPG") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageForDownload.image = image
                self.imageForDownload.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}

