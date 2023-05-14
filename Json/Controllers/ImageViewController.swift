//
//  ImageViewController.swift
//  Json
//
//  Created by Anton Akhmedzyanov on 14.05.2023.
//

import UIKit

final class ImageViewController: UIViewController {

   @IBOutlet var pictureImageView: UIImageView!
   @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    private func fetchImage() {
        let urlImage = URL(string: "https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80")!
        URLSession.shared.dataTask(with: urlImage) {[weak self] data, response, error in
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            
            DispatchQueue.main.async {
                self?.pictureImageView.image = UIImage(data: data)
                self?.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
