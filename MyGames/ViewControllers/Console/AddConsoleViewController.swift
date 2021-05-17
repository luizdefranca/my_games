//
//  AddConsoleViewController.swift
//  MyGames
//
//  Created by Luiz Carlos F Ramos on 17/05/21.
//

import UIKit
import Photos

class AddConsoleViewController: UIViewController {

//MARK: - Outlets
    
    @IBOutlet weak var tfPlataforma: UITextField!
    
    @IBOutlet weak var ivCover: UIImageView!
    
    
    
//MARK: - Proprieties
    // tip. Lazy somente constroi a classe quando for usar
  
    
    private func chooseImageFromLibrary(sourceType: UIImagePickerController.SourceType) {
        
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.navigationBar.tintColor = UIColor(named: "main")
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    
                    self.chooseImageFromLibrary(sourceType: sourceType)
                    
                } else {
                    
                    print("unauthorized -- TODO message")
                }
            })
        } else if photos == .authorized {
            self.chooseImageFromLibrary(sourceType: sourceType)
        } else if photos == .denied {
            print("unauthorized -- TODO message")
            
            //TODO: mostrar ym dialogo para convencer o usuario para dar permissao manualmente
        }
    }
    
}


extension AddConsoleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // tip. implementando os 2 protocols o evento sera notificando apos user selecionar a imagem
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // ImageView won't update with new image
            // bug fixed: https://stackoverflow.com/questions/42703795/imageview-wont-update-with-new-image
            DispatchQueue.main.async {
                self.ivCover.image = pickedImage
                self.ivCover.setNeedsDisplay()
//                self.btCover.setTitle(nil, for: .normal)
//                self.btCover.setNeedsDisplay()
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
