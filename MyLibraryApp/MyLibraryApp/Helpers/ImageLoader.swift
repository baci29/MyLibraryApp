//
//  ImageLoader.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }
    }
}
