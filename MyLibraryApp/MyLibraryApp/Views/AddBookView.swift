//
//  AddBookView.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import SwiftUI

struct AddBookView: View {
    @EnvironmentObject var viewModel: LibraryViewModel
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var isbn: String = ""
    @State private var isScannerPresented = false
    @State private var isFetching = false
    @State private var fetchError: String?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informace o knize")) {
                    TextField("Název knihy", text: $title)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                    TextField("Autor", text: $author)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }

                Section(header: Text("Další možnosti")) {
                    Button(action: {
                        isScannerPresented = true
                    }) {
                        Label("Skenovat ISBN", systemImage: "barcode.viewfinder")
                    }
                    .sheet(isPresented: $isScannerPresented) {
                        ISBNScannerView { scannedISBN in
                            isbn = scannedISBN
                            fetchBookDetails(isbn: scannedISBN)
                        }
                    }

                    if isFetching {
                        ProgressView("Načítání knihy...")
                    }

                    if let error = fetchError {
                        Text("Chyba: \(error)")
                            .foregroundColor(.red)
                    }
                }

                Button(action: addBook) {
                    Text("Přidat knihu")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(isFetching || title.isEmpty || author.isEmpty)
            }
            .navigationTitle("Přidat Knihu")
        }
    }

    private func fetchBookDetails(isbn: String) {
        isFetching = true
        fetchError = nil

        GoogleBooksAPIService().fetchBookDetails(byISBN: isbn) { result in
            DispatchQueue.main.async {
                isFetching = false
                switch result {
                case .success(let book):
                    title = book.title
                    author = book.author
                case .failure(let error):
                    fetchError = error.localizedDescription
                }
            }
        }
    }

    private func addBook() {
        let newBook = Book(
            id: UUID(),
            title: title,
            author: author,
            isbn: isbn,
            rating: 0,
            notes: "",
            category: .toRead,
            currentPage: 0,
            totalPages: 0
        )
        viewModel.addBook(newBook)
        clearFields()
    }

    private func clearFields() {
        title = ""
        author = ""
        isbn = ""
    }
}


struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
            .environmentObject(LibraryViewModel())
    }
}
