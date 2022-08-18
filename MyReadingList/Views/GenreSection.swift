//
//  GenreSection.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-26.
//

import SwiftUI

struct GenreSection: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    var genre: String
    
    var body: some View {
        
        // Genre name
        Text(genre).font(.title2)
            .onAppear() {
                readingListModel.getBooksByGenre(genre: genre)
            }
        
        // Check if the genre name exists in the books dictionary
        if(readingListModel.books[genre] != nil) {
            // Get all the books associated with the genre
            let books = readingListModel.books[genre]!
            
            // Display each book title and author to click on to navigate to more details
            ForEach(books, id: \.self) { book in
                NavigationLink(destination: BookDetails(book: book)) {
                    HStack(){
                        Text("\(book.title)")
                            .font(.headline)
                        Text("by \(book.author)")
                    }
                    .padding([.top, .leading, .bottom], 10.0)
                    
                }
            }
        }
    }
}

