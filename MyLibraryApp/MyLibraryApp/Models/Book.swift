//
//  Book.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import Foundation

struct Book: Identifiable {
    let id: UUID
    var title: String
    var author: String
    var isbn: String
    var rating: Int
    var notes: String
    var category: BookCategory
    var currentPage: Int
    var totalPages: Int 
}

enum BookCategory {
    case toRead, reading, finished
}
