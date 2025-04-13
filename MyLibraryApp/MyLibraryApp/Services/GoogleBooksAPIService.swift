//
//  GoogleBooksAPIService.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import Foundation

class GoogleBooksAPIService {
    func fetchBookDetails(byISBN isbn: String, completion: @escaping (Result<Book, Error>) -> Void) {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let items = json?["items"] as? [[String: Any]],
                   let volumeInfo = items.first?["volumeInfo"] as? [String: Any] {
                    let title = volumeInfo["title"] as? String ?? "Neznámý název"
                    let authors = (volumeInfo["authors"] as? [String])?.joined(separator: ", ") ?? "Neznámý autor"
                    
                    let book = Book(
                        id: UUID(),
                        title: title,
                        author: authors,
                        isbn: isbn,
                        rating: 0,
                        notes: "",
                        category: .toRead,
                        currentPage: 0,
                        totalPages: 0
                    )
                    completion(.success(book))
                } else {
                    completion(.failure(NSError(domain: "No book details found", code: 404, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
