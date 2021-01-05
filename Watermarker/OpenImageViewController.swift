//
//  OpenImageViewController.swift
//  Watermarker
//
//  Created by Yigang Zhou on 2020/12/31.
//

import UIKit

class OpenImageViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private let segueIdentifier = "showWatermarkPannel"
    private var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
    }
    
    @IBAction func openImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    self.present(imagePicker, animated: true, completion: nil)
                }
                else
                {
                    let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                self.selectedImage = pickedImage
                performSegue(withIdentifier: self.segueIdentifier, sender: self)
                print(pickedImage)
            }
            picker.dismiss(animated: true, completion: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueIdentifier {
            if let image = self.selectedImage {
                let controller = segue.destination as! ViewController
                controller.img = self.selectedImage
            }
            
        }
    }
}
