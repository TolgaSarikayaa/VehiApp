//
//  AddUserView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 25.07.24.
//

import Foundation
import SwiftUI
import ContactsUI

struct AddUserView: UIViewControllerRepresentable {
    @Binding var user: String
    @Binding var userImage: UIImage?

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: AddUserView

        init(_ parent: AddUserView) {
            self.parent = parent
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.user = contact.givenName + " " + contact.familyName
            if let imageData = contact.imageData {
                parent.userImage = UIImage(data: imageData)
            }
        }
        
        func requestContactsAccess(completion: @escaping (Bool) -> Void) {
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { grandet, error in
                DispatchQueue.main.async {
                    completion(grandet)
                }
            }
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            // Optional: Handle cancel event if needed
        }
    }

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}
}
