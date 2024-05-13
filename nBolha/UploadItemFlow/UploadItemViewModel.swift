//
//  UploadItemViewModel.swift
//  nBolha
//
//  Created by David Balažic on 9. 5. 24.
//

import Foundation
import PhotosUI
import SwiftUI
import Combine

protocol UploadItemNavigationDelegate: AnyObject {
 
}

final class UploadItemViewModel: ObservableObject {
    private let navigationDelegate: UploadItemNavigationDelegate?
    @Published var pickerItems = [PhotosPickerItem]()
    @Published var selectedImages = [UIImage]()
    
    init(
        navigationDelegate: UploadItemNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
    }
    
    func updatePickerItems() {
        selectedImages = []
        for item in pickerItems {
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let imageData):
                    if let imageData {
                        self.selectedImages.append(UIImage(data: imageData)!)
                    } else {
                        print("No supported content type found.")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func removeImage(at index: Int) {
        self.selectedImages.remove(at: index)
        self.pickerItems.remove(at: index)
    }
    
    func rotateImage(at index: Int) {
        let image = selectedImages[index]
        let newImage = image.rotate(radians: .pi/2)
        selectedImages[index] = newImage ?? UIImage()
    }
    
    func moveImageUp(at index: Int) {
        if index > 0 {
            selectedImages.swapAt(index, index - 1)
            pickerItems.swapAt(index, index - 1)
        }
        else {
            let removedItem = selectedImages[index]
            selectedImages.remove(at: index)
            selectedImages.append(removedItem)
            let removedPickerItem = pickerItems[index]
            pickerItems.remove(at: index)
            pickerItems.append(removedPickerItem)
        }
    }
    
    func moveImageDown(at index: Int) {
        if index < selectedImages.count - 1 {
            selectedImages.swapAt(index, index + 1)
            pickerItems.swapAt(index, index + 1)
        }
        else {
            let removedItem = selectedImages[index]
            selectedImages.remove(at: index)
            selectedImages.insert(removedItem, at: 0)
            let removedPickerItem = pickerItems[index]
            pickerItems.remove(at: index)
            pickerItems.insert(removedPickerItem, at: 0)
        }
    }
}
