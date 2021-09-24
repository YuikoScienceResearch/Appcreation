//
//  UploadViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 9/12/21.
//

import UIKit

extension String {
    static let keyForImage = "data"
}

class UploadViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        retriveData(key: .keyForImage)
    }
    
    
    @IBAction func choosingimage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    func save(image: UIImage) {
        let imageData = image.pngData()! as NSData
        
        UserDefaults.standard.set(imageData, forKey: .keyForImage)
    }
    
    func retriveData(key: String) {
        guard let data = UserDefaults.standard.value(forKey: key) as? NSData else { return }
        let image = UIImage(data: data as Data)
        imageView.image = image
    }
    
}

extension UploadViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        save(image: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

