//
//  LibraryViewModel.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import Foundation

class LibraryViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func removeBook(_ book: Book) {
        books.removeAll { $0.id == book.id }
    }
    
    func updateBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index] = book
        }
    }
}
