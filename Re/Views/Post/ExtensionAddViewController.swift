//
//  ExtensionAddViewController.swift
//  Re
//
//  Created by 황인호 on 12/2/23.
//

import UIKit
import PhotosUI

extension AddViewController: UITextViewDelegate {
    
    func insertImage(_ image: UIImage) {
        
        photoImageView.image = image
        
        
        let scaleFactor = photoImageView.frame.width / image.size.width
        let newImageSize = CGSize(width: photoImageView.frame.width, height: image.size.height * scaleFactor)
        photoImageView.bounds = CGRect(origin: .zero, size: newImageSize)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.changeTextColor()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
        }
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        var newSelections = [String: PHPickerResult]()
        
        for result in results {
            guard let identifier = result.assetIdentifier else { return }
            newSelections[identifier] = selections[identifier] ?? result
        }
        
        selections = newSelections
        //assetidentifier는 옵셔널 값이라서 compactmap으로 받음
        selectedAssetIdentifier = results.compactMap { $0.assetIdentifier }
        
        displayImage()
    }
    
    private func displayImage() {
        let dispatchGroup = DispatchGroup()
        var imagesDict = [String: UIImage]()
        
        for (identifier, result) in selections {
            dispatchGroup.enter()
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            let downImage = image.downSample(size: self.view.bounds.size)
                            imagesDict[identifier] = downImage
                        }
                        dispatchGroup.leave()
                    }
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
                guard let self = self else { return }
                
                for identifier in self.selectedAssetIdentifier {
                    guard let image = imagesDict[identifier] else { return }
                    self.insertImage(image)
                }
            }
        }
    }
}
