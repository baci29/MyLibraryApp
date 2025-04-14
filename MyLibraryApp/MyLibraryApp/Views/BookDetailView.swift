//
//  BookDetailView.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var viewModel: LibraryViewModel
    @State var book: Book
    @State private var newNote: String = ""
    @State private var notes: [String] = []
    @State private var progress: Double = 0.0

    var body: some View {
        Form {
            // Poznámky
            Section(header: Text("Poznámky")) {
                ForEach(notes, id: \.self) { note in
                    Text(note)
                }
                TextField("Nová poznámka", text: $newNote) // Zadání nové poznámky
                Button(action: addNote) {
                    Label("Přidat poznámku", systemImage: "plus")
                }
            }

            // Progres čtení
            Section(header: Text("Progres čtení")) {
                HStack {
                    Text("Aktuální stránka:")
                    Spacer()
                    TextField("Např. 50", value: $book.currentPage, format: .number)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .onChange(of: book.currentPage) { _ in updateProgress() }
                }

                HStack {
                    Text("Celkový počet stran:")
                    Spacer()
                    TextField("Např. 100", value: $book.totalPages, format: .number)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .onChange(of: book.totalPages) { _ in updateProgress() }
                }

                ProgressView(value: progress, total: 1.0)
                    .accentColor(.green)

                Text("\(Int(progress * 100))% přečteno")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Hodnocení
            Section(header: Text("Hodnocení")) {
                HStack {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= book.rating ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                book.rating = star
                                saveChanges()
                            }
                    }
                }
            }
        }
        .navigationTitle(book.title)
        .onAppear {
            initializeNotes()
            updateProgress()
        }
    }

    private func addNote() {
        if !newNote.isEmpty {
            notes.append(newNote)
            newNote = ""
            book.notes = notes.joined(separator: "\n")
            saveChanges()
        }
    }

    private func initializeNotes() {
        notes = book.notes.components(separatedBy: "\n")
    }

    private func updateProgress() {
        guard book.totalPages > 0 else {
            progress = 0.0
            return
        }
        progress = Double(book.currentPage) / Double(book.totalPages)
        saveChanges()
    }

    private func saveChanges() {
        viewModel.updateBook(book) 
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(
            book: Book(
                id: UUID(),
                title: "Ukázková kniha",
                author: "Autor knihy",
                isbn: "1234567890",
                rating: 4,
                notes: "",
                category: .toRead,
                currentPage: 50,
                totalPages: 100
            )
        )
        .environmentObject(LibraryViewModel())
    }
}
