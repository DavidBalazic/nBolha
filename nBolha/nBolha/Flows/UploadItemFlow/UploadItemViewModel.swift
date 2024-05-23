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
import nBolhaNetworking
import nBolhaCore
import nBolhaUI

protocol UploadItemNavigationDelegate: AnyObject {
    func showProfileScreen()
}

final class UploadItemViewModel: ObservableObject {
    private let navigationDelegate: UploadItemNavigationDelegate?
    private let notificationService: WindowNotificationService
    private var cancellables = Set<AnyCancellable>()
    private var shouldLoadTransferables = true
    @Published var isLoading = false
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
    @Published var errorAddPhotosText: String?
    @Published var pickerItems = [PhotosPickerItem]() {
        didSet {
            if shouldLoadTransferables {
                Task {
                    try await loadTransferables(from: pickerItems)
                }
            }
        }
    }
    
    enum Category: String, CaseIterable {
        case unselected = "Select..."
        case home = "Home"
        case construction = "Construction"
        case automotive = "Automotive"
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
        navigationDelegate: UploadItemNavigationDelegate?,
        notificationService: WindowNotificationService = DefaultWindowNotificationService()
    ) {
        self.navigationDelegate = navigationDelegate
        self.notificationService = notificationService
        initializeObserving()
    }
    
    private func initializeObserving() {
        $title
            .dropFirst()
            .map { title in
                if title.isEmpty {
                    return "Please enter title"
                } else if title.count > 50 {
                    return "\(title.count)/50"
                } else {
                    return nil
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.errorTitleText = newText
            }
            .store(in: &cancellables)
        
        $description
            .dropFirst()
            .map { $0.count > 1000 ? "\($0.count)/1000" : nil }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.errorDescriptionText = newText
            }
            .store(in: &cancellables)
        
        $price
            .dropFirst()
            .map { $0.isEmpty ? "Please enter price" : nil }
            .combineLatest($price.validPricePublisher)
            .map { inputError, validPrice in
                if let inputError = inputError {
                    return inputError
                } else if !validPrice {
                    return "Price is from 0€ to 999.999€"
                } else {
                    return nil
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.errorPriceText = newText
            }
            .store(in: &cancellables)
        
        $category
            .dropFirst()
            .map { category in
                category == .unselected ? "Please select category" : nil
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.errorCategoryText = newText
            }
            .store(in: &cancellables)
        
        $condition
            .dropFirst()
            .map { condition in
                condition == .unselected ? "Please select condition" : nil
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.errorConditionText = newText
            }
            .store(in: &cancellables)
        
        $location
            .dropFirst()
            .map { location in
                location == .unselected ? "Please select location" : nil
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.errorLocationText = newText
            }
            .store(in: &cancellables)
        
        $selectedImages
            .dropFirst()
            .map { $0.isEmpty ? "Please add a minimum of 1 photo" : nil }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.errorAddPhotosText = newText
            }
            .store(in: &cancellables)
    }
    
    private func validateFields() {
        errorTitleText = {
            if title.isEmpty {
                return "Please enter title"
            } else if title.count > 50 {
                return "\(title.count)/50"
            } else {
                return nil
            }
        }()
        errorDescriptionText = description.count > 1000 ? "\(description.count)/1000"  : nil
        errorPriceText  = {
            if price.isEmpty {
                return "Please enter price"
            } else if let priceValue = Double(price), priceValue > 999999 {
                return "Price is from 0€ to 999.999€"
            } else {
                return nil
            }
        }()
        errorCategoryText = category == .unselected ? "Please select category" : nil
        errorConditionText = condition == .unselected ? "Please select condition" : nil
        errorLocationText = location == .unselected ? "Please select location" : nil
        errorAddPhotosText = selectedImages.isEmpty ? "Please add a minimum of 1 photo" : nil
    }
    
    private func isUploadAllowed() -> Bool {
        return !title.isEmpty &&
                title.count < 50 &&
                description.count < 1000 &&
                !price.isEmpty &&
                Double(price) != nil &&
                Double(price)! <= 999999 &&
                category != .unselected &&
                condition != .unselected &&
                location != .unselected &&
                !selectedImages.isEmpty
    }
    
    private func resetFields() {
        shouldLoadTransferables = false
        defer { shouldLoadTransferables = true }
        
        cancellables.removeAll()
        title = ""
        description = ""
        price = ""
        category = .unselected
        condition = .unselected
        location = .unselected
        selectedImages.removeAll()
        pickerItems.removeAll()
        initializeObserving()
    }
    
    @MainActor
    func uploadItemTapped() async {
        validateFields()
        guard isUploadAllowed() else { return }
        await uploadItem()
    }
    
    @MainActor
    private func uploadItem() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let postAdvertisementWorker = PostAdvertisementWorker(
            //TODO: wait for backend update and implement
            title: title,
            description: description,
            price: Double(price) ?? 0.0,
            address: location.rawValue,
            category: category.rawValue,
            condition: "Very_good",
            images: selectedImages
        )
        postAdvertisementWorker.execute { (response, error) in
            if let response = response {
                self.resetFields()
                self.navigationDelegate?.showProfileScreen()
            } else if let error = error {
                self.notificationService.notify.send(NotificationView.Notification.UploadFailed)
            }
        }
    }
    
    func loadTransferables(from selection: [PhotosPickerItem]?) async throws {
        guard let selection = selection else { return }
        var tempImages = [UIImage]()
        for item in selection {
            if let data = try await item.loadTransferable(type: Data.self) {
                let maxSizeInBytes = 2 * 1024 * 1024
                if data.count <= maxSizeInBytes {
                    if let uiImage = UIImage(data: data) {
                        tempImages.append(uiImage)
                    }
                }
                else {
                    self.notificationService.notify.send(NotificationView.Notification.PhotoUploadFailed)
                    self.selectedImages.removeAll()
                    self.pickerItems.removeAll()
                    return
                }
            }
        }
        self.selectedImages = tempImages
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
    }
    
    func moveImageDown(at index: Int) {
        if index < selectedImages.count - 1 {
            selectedImages.swapAt(index, index + 1)
            pickerItems.swapAt(index, index + 1)
        }
    }
}
