//
//  ViewController.swift
//  deltaHacksCamera
//
//  Created by Andrew Carvalino on 2020-01-26.
//  Copyright © 2020 Andrew Carvalino. All rights reserved.
//
//  Some of the code was acquired from the website Medium at https://appsandbiscuits.com/take-save-and-retrieve-a-photo-ios-13-4312f96793ff
//  Other parts of the code are from hackingwithswift.com
//

import UIKit

class ViewController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagePickerController : UIImagePickerController!
    
    var numberOfPhotos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var imageView: UIImageView!
    
    /*
     Function that controls the capturing of a photo (does not implement editing
     as the photo is assumed to be correct and ready for analysis).
     */
    @IBAction func captureButton(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera //directs the view controller to the camera as opposed to library
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        //imageView.image = info[String(UIImagePickerControllerOriginalImage)] as? UIImage
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //both versions of the line above produce an error, and I am not sure how to go about fixing it, even after searching online
    }
    
    func saveImage(imageName: String){
       //create an instance of the FileManager
       //let fileManager = FileManager.default
       //get the image path (as String)
       //let imagePathStr = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        //get image path (as URL)
        let imagePathURL = getDocumentsDirectory().appendingPathComponent(imageName)
        //get the image we took with camera
        let image = imageView.image!
        //get the PNG data for this image
        let imageData = image.pngData()
        //store it in the document directory    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        try? imageData?.write(to: imagePathURL)
    }
    
    @IBAction func savingButton(_ sender: Any) {
        numberOfPhotos += 1
        saveImage(imageName: "image\(numberOfPhotos).png")
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
}

