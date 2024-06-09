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
    private let keychaninManager = KeyChainManager(service: Constants.keychainServiceIdentifier)
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
        notificationService: WindowNotificationService = DefaultWindowNotificationService(),
        showSuccessMessage: Bool = false
    ) {
        self.navigationDelegate = navigationDelegate
        self.notificationService = notificationService
        if showSuccessMessage {
            notificationService.notify.send(NotificationView.Notification.PhotoUploadSuccess)
        }
        Task {
            await loadProfileInfo()
        }
    }
    
    @MainActor
    func loadProfileInfo() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let getUserInfoWorker = GetUserInfoWorker()
        do {
            let response = try await GetUserInfoWorker().execute()
            self.profile = response
        } catch {
            print("Error loading profile information: \(error)")
        }
    }
    
    @MainActor
    func loadProfileAdvertisements() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        let getUserAdvertisementsWorker = GetUserAdvertisementsWorker()
        do {
            let response = try await GetUserAdvertisementsWorker().execute()
            self.profileAdvertisements = response ?? []
        } catch {
            print("Error loading profile advertisements: \(error)")
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
    
    @MainActor
    func uploadProfilePicture(profileImage: UIImage) async {
        do {
            _ = try await UploadProfilePictureWorker(image: profileImage).execute()
            await loadProfileInfo()
        } catch {
            print("Error uploading profile picture: \(error)")
        }
    }
    
    @MainActor
    func deleteAdvertisement() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        guard let advertisementId = advertisementToDelete?.advertisementId else { return }
        do {
            _ = try await DeleteAdvertisementWorker(advertisementId: advertisementId).execute()
            
            if let index = profileAdvertisements.firstIndex(where: { $0.advertisementId == advertisementId }) {
                profileAdvertisements.remove(at: index)
                advertisementToDelete = nil
            }
        } catch {
            print("Error deleting advertisement: \(error)")
        }
    }
    
    func setAdvertisementToDelete(_ advertisement: Advertisement) {
        self.advertisementToDelete = advertisement
    }
    
    func deleteAdvertisementTapped() async {
        await deleteAdvertisement()
    }
    
    func onAppear() {
        Task { await loadProfileAdvertisements() }
    }
    
    func signOutTapped() {
        keychaninManager.remove("sessionTokenID")
        NotificationCenter.default.post(name: .tokenExpiredNotification, object: nil)
    }
    
    func advertisementItemTapped(advertisementId: Int) {
        navigationDelegate?.showDetailScreen(advertisementId: advertisementId)
    }
}
