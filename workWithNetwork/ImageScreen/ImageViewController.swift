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
        NetworkManager.downloadImage { [weak self] (data) in
            self?.imageForDownload.image = UIImage(data: data)
            self?.activityIndicator.stopAnimating()
            self?.imageForDownload.isHidden = false
        }
    }
}

