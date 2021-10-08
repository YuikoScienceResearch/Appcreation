//
//  UploadViewController.swift
//  ScienceResearchApp
//
//  Created by Yuiko Suzuki on 9/12/21.
//

import UIKit


class UploadViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var groupName: String?
    var bucketListName: String?
    var bucketListItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveData(key: "\(groupName)_\(bucketListName)_\(bucketListItem)")
    }
    
    
    @IBAction func choosingimage(_ sender: Any) {
    let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @IBAction func uploadimage(_ sender: Any) {
    if imageView.image == nil {
            return
    }
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    func save(image: UIImage) {
        let imageData = image.pngData()! as NSData
        
        UserDefaults.standard.set(imageData, forKey: "\(groupName)_\(bucketListName)_\(bucketListItem)")
        
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
