//
//  PhotosViewController.swift
//  photorama
//
//  Created by Joshua Vandermost on 2020-03-23.
//  Copyright © 2020 Joshua Vandermost. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet var uiView: UIView!
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    var photoArray = [Photo]()
    var increment = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        uiView.addGestureRecognizer(tapRecognizer)

        store.fetchInterestingPhotos{
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                self.photoArray = photos
                print("successfully found \(photos.count) photos")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fatching interesting photos: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func tap(_ gestureRecognizer: UIGestureRecognizer){
        increment+=1
        self.updateImageView(for: photoArray[increment])
    }
    
    func updateImageView(for photo: Photo){
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
