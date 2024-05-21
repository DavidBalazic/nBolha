//
//  ProfileViewModel.swift
//  nBolha
//
//  Created by David Balažic on 17. 5. 24.
//

import Foundation
import nBolhaNetworking
import PhotosUI
import SwiftUI
import nBolhaUI

protocol ProfileNavigationDelegate: AnyObject {
    func showDetailScreen(advertisementId: Int)
}

final class ProfileViewModel: ObservableObject {
    private let navigationDelegate: ProfileNavigationDelegate?
    private let notificationService: WindowNotificationService
    @Published var isLoading = false
    @Published var profileAdvertisements: [Advertisement] = []
    @Published var profile: User?
    @Published var advertisementToDelete: Advertisement?
    @Published var photosPickerItem: PhotosPickerItem? {
        didSet {
            Task {
                try await loadTransferables(from: photosPickerItem)
            }
        }
    }
    
    init(
        navigationDelegate: ProfileNavigationDelegate?,
        notificationService: WindowNotificationService = DefaultWindowNotificationService()
    ) {
        self.navigationDelegate = navigationDelegate
        self.notificationService = notificationService
        Task {
            await loadProfileAdvertisements()
            await loadProfileInfo()
        }
    }
    
    func loadProfileInfo() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let getUserInfoWorker = GetUserInfoWorker()
        getUserInfoWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.profile = response
            }
        }
    }
    
    func loadProfileAdvertisements() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let getUserAdvertisementsWorker = GetUserAdvertisementsWorker()
        getUserAdvertisementsWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                self.profileAdvertisements = response ?? []
            }
        }
    }
    
    func loadTransferables(from selection: PhotosPickerItem?) async throws {
        if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
            let maxSizeInBytes = 2 * 1024 * 1024
            if data.count <= maxSizeInBytes {
                if let uiImage = UIImage(data: data) {
                    Task{ await uploadProfilePicture(profileImage: uiImage) }
                }
            }
            else {
                self.notificationService.notify.send(NotificationView.Notification.PhotoUploadFailed)
                return
            }
        }
    }
    
    func uploadProfilePicture(profileImage: UIImage) async {
        let uploadProfilePictureWorker = UploadProfilePictureWorker(image: profileImage)
        uploadProfilePictureWorker.execute { response, error in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                Task {
                    await self.loadProfileInfo()
                }
            }
        }
    }
    
    func deleteAdvertisement() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        guard let advertisementId = advertisementToDelete?.advertisementId else { return }
        let deleteAdvertisementWorker = DeleteAdvertisementWorker(advertisementId: advertisementId)
        deleteAdvertisementWorker.execute { (response, error) in
            if let error = error {
                print("Error loading advertisements: \(error)")
            } else {
                if let index = self.profileAdvertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                    self.profileAdvertisements.remove(at: index)
                    self.advertisementToDelete = nil
                }
            }
        }
    }
    
    func setAdvertisementToDelete(_ advertisement: Advertisement) {
        self.advertisementToDelete = advertisement
    }
    
    func advertisementItemTapped(advertisementId: Int) {
        navigationDelegate?.showDetailScreen(advertisementId: advertisementId)
    }
    
    func deleteAdvertisementTapped() async {
        await deleteAdvertisement()
    }
}
