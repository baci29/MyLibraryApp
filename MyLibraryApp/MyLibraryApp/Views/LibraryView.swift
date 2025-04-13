//
//  LibraryView.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var viewModel: LibraryViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                                .lineLimit(1)
                            Text(book.author)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            HStack {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= book.rating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Knihovna")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddBookView()) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
    }
}



struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environmentObject(LibraryViewModel()) 
    }
}
