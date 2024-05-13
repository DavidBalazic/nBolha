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
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var price: String = ""
    @Published var errorTitleText: String?
    @Published var errorDescriptionText: String?
    @Published var errorPriceText: String?
    @Published var category: Category = .unselected
    @Published var condition: Condition = .unselected
    @Published var location: Location = .unselected
    @Published var errorCategoryText: String?
    @Published var errorConditionText: String?
    @Published var errorLocationText: String?
    
    enum Category: String, CaseIterable {
        case unselected = "Select..."
        case home = "Home"
        case construction = "Construction"
        case automative = "Automative"
        case sport = "Sport"
        case audiovisual = "Audiovisual"
        case literature = "Literature"
        case hobbies = "Hobbies"
        case apparel = "Apparel"
        case services = "Services"
    }
    enum Condition: String, CaseIterable {
        case unselected = "Select..."
        case withTags = "New with tags"
        case withoutTags = "New without tags"
        case veryGood = "Very good"
        case satisfactory = "Satisfactory"
    }
    enum Location: String, CaseIterable {
        case unselected = "Select..."
        case maribor = "Maribor"
        case ljubljana = "Ljubljana"
    }
    
    init(
        navigationDelegate: UploadItemNavigationDelegate?
    ) {
        self.navigationDelegate = navigationDelegate
        initializeObserving()
    }
    
    private func initializeObserving() {
        $title
            .dropFirst()
            .map { $0.isEmpty ? "Please enter title" : nil }
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorTitleText)
           
        $description
            .dropFirst()
            .map { $0.count > 10 ? "\($0.count)/1000" : nil }
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorDescriptionText)
        
        $price
            .dropFirst()
            .map { $0.isEmpty ? "Please enter price" : nil }
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorPriceText)
        
        $category
            .dropFirst()
            .map { category in
                category == .unselected ? "Please select category" : nil
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorCategoryText)
        
        $condition
            .dropFirst()
            .map { condition in
                condition == .unselected ? "Please select condition" : nil
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorConditionText)
        
        $location
            .dropFirst()
            .map { location in
                location == .unselected ? "Please select location" : nil
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorLocationText)
    }
    
    private func validateFields() {
        errorTitleText = title.isEmpty ? "Please enter title" : nil
        errorDescriptionText = description.count > 10 ? "\(description.count)/1000"  : nil
        errorPriceText = price.isEmpty ? "Please enter price" : nil
        errorCategoryText = category == .unselected ? "Please select category" : nil
        errorConditionText = condition == .unselected ? "Please select condition" : nil
        errorLocationText = location == .unselected ? "Please select location" : nil
    }
    
    func uploadItemTapped() {
        validateFields()
        //TODO: implement
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
