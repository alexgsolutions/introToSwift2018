//
//  ViewController.swift
//  Permitions_AGL
//
//  Created by Alexis Gonzalez on 5/22/18.
//  Copyright © 2018 alexgsolutions. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate{

    
    @IBOutlet weak var imageViewIcon: UIImageView! {
        didSet {
            imageViewIcon.contentMode = .scaleAspectFill
            imageViewIcon.clipsToBounds = true
            imageViewIcon.layer.cornerRadius = 100
        }
    }
    
    fileprivate let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
    }
    
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) {[weak self] (_) in
           self?.handleTakePhoto()
        }
        
        let photoLibraryAction = UIAlertAction(title: "From Library", style: .default) { [weak self] (_) in
           self?.presentLibraryPhotoPicker()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(takePhotoAction)
        alert.addAction(photoLibraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    private func handleTakePhoto() {
        if hasDeniedCameraAccess {
            print("take user to the setting")
        }else {
            presentCameraPhotoPicker()
        }
    }
    private func presentLibraryPhotoPicker() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }


    private func presentCameraPhotoPicker() {
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        present(picker, animated: true, completion: nil)
    }
    
    private func presentCameraSettingAlert() {
        let alert = UIAlertController(title: "Grand Access to the Camera", message: "Escribir todo", preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "Sure", style: .default) {[weak self] (_) in
            self?.takeUserToSettings()
        }
        let noThanksAction = UIAlertAction(title: "No Thanks", style: .cancel, handler: nil)
        
        alert.addAction(sureAction)
        alert.addAction(noThanksAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func takeUserToSettings() {
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }

}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
         imageViewIcon.image = originalImage
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    var cameraPermitionStatus: AVAuthorizationStatus {
        let cameraMediaType = AVMediaType.video
        return AVCaptureDevice.authorizationStatus(for: cameraMediaType)
    }
    var hasDeniedCameraAccess: Bool {
        return cameraPermitionStatus == .denied
    }
}

