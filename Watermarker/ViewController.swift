//
//  ViewController.swift
//  Watermarker
//
//  Created by Yigang Zhou on 2020/12/31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var seperationSlider: UISlider!
    @IBOutlet weak var colorSegmentControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var colors:[UIColor] = [.red,.yellow, .blue, .green, .black]
    
    var imageWatermarkCore: ImageWatermarkCore!
    var img: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFit
        imageWatermarkCore = ImageWatermarkCore(image: img)
        imageView.image = imageWatermarkCore.getWatermarkedImage()
        imageWatermarkCore.onImageWatermarkUpdate { (image) in
            self.imageView.image = image
        }
        
        textField.returnKeyType = .done
        fontSizeSlider.addTarget(self, action: #selector(self.onFontSizeChange), for: .valueChanged)
        fontSizeSlider.isContinuous = false
        opacitySlider.addTarget(self, action: #selector(self.onOacityChange), for: .valueChanged)
        opacitySlider.isContinuous = false
        seperationSlider.addTarget(self, action: #selector(self.onSeperationChange), for: .valueChanged)
        seperationSlider.isContinuous = false
        colorSegmentControl.addTarget(self, action: #selector(self.onColorSegmentationChange), for: .valueChanged)
        textField.delegate = self
  
    }

    @objc func onColorSegmentationChange() {
        imageWatermarkCore.updateColor(color: colors[self.colorSegmentControl.selectedSegmentIndex])
    }
    
    @objc func onFontSizeChange() {
        imageWatermarkCore.updateFontSize(withFactor: fontSizeSlider.value)
    }
    
    @objc func onSeperationChange() {
        imageWatermarkCore.updateSeperation(withFactor: seperationSlider.value)
    }
    
    @objc func onOacityChange() {
        imageWatermarkCore.updateOpacity(withFactor: opacitySlider.value)
    }
    
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil{
            let alert  = UIAlertController(title: "Success", message: "Save success", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    @IBAction func onSaveImageClick(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(imageWatermarkCore.getWatermarkedImage(), self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), .none)
    }
    
 
}



extension ViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let content = textField.text {
            imageWatermarkCore.updateContent(content: content)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
    }
}
