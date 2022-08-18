//
//  BookDetails.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-26.
//

import SwiftUI

struct BookDetails: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var selectedGenre: Int = 0
    @State var selectedStatus: Int = 0
    @State var selectedRating: Int = 0
    var book: Book
    
    var body: some View {
        // Details for the book
        VStack {
            ScrollView() {
                Text(book.title)
                    .font(.headline)
                    // Update picker references with the book data
                    .onAppear() {
                        selectedGenre = readingListModel.genres.firstIndex(of: book.genre) ?? 0
                        selectedStatus = readingListModel.statuses.firstIndex(of: book.status) ?? 0
                        selectedRating = book.rating
                    }
                
                Text(book.author)
                
                if(book.pages != 0) {
                    Text("Pages: \(book.pages)")
                }
                Divider()
                
                // Stack with all the pickers
                VStack {
                    Text("Rating:")
                    //Picker with all the ratings
                    Picker(selection: $selectedRating, label: Text("")) {
                        ForEach(0..<6) { rating in
                            if(rating == 0) {
                                Text("N/A")
                            }
                            else {
                                Text("\(rating)")
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Status:")
                    //Picker with all the statuses defined in the view model
                    Picker(selection: $selectedStatus, label: Text("")) {
                        ForEach(0..<readingListModel.statuses.count) {
                            Text(readingListModel.statuses[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                    Text("Genre:")
                    //Picker with all the genres
                    Picker(selection: $selectedGenre, label: Text("")) {
                        ForEach(0..<readingListModel.genres.count) {
                            Text(readingListModel.genres[$0])
                        }
                    }
                }
                
                // Button to save changes and make update to the database
                Button {
                    // Create a book with all the updated data
                    let updatedBook = Book(id: book.id, title: book.title, author: book.author, genre: readingListModel.genres[selectedGenre], status: readingListModel.statuses[selectedStatus], pages: book.pages, rating: selectedRating)
                    
                    readingListModel.updateBookData(book: updatedBook)
                } label: {
                    Text("Save Changes")
                }
                
                // Button to delete the book from the database
                Button {
                    readingListModel.deleteBook(book: book)
                } label: {
                    Text("Delete Book")
                        .padding(5)
                }
                Spacer()
            }
        }
    }
}

