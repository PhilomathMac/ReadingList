//
//  AddBook.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-26.
//

import SwiftUI
import Combine

struct AddBook: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var bookTitle: String = ""
    @State var bookAuthor: String = ""
    @State var bookPages: String = ""
    @State var selectedGenre: Int = 0
    @State var selectedStatus: Int = 0
    @State var selectedRating: Int = 0
    
    var body: some View {
        VStack {
            ScrollView() {
                // Text boxes for book title, author, and number of pages
                TextField("Book Title", text: $bookTitle)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                TextField("Book Author(s)", text: $bookAuthor)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                TextField("Number of Pages", text: $bookPages)
                    // Filter the input for only numbers
                    .keyboardType(.numberPad)
                    .onReceive(Just(bookPages)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.bookPages = filtered
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                // Stack with all the pickers for ratings, statuses, genres
                VStack {
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
                    .padding([.leading, .trailing], 20)
                    }
                    
                    Spacer()
                    
                    VStack {
                    Text("Status:")
                    //Picker with all the statuses defined in the ViewModel
                    Picker(selection: $selectedStatus, label: Text("")) {
                        ForEach(0..<readingListModel.statuses.count) {
                            Text(readingListModel.statuses[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing], 20)
                    }
                    
                    Spacer()
                    
                    VStack {
                    Text("Genre:")
                    //Picker with all the genres
                    Picker(selection: $selectedGenre, label: Text("")) {
                        ForEach(0..<readingListModel.genres.count) {
                            Text(readingListModel.genres[$0])
                        }
                    }
                    .pickerStyle(.wheel)
                    }
                }
                
                // Button to add the book to the database
                Button {
                    // Check if the title or author is blank
                    if(bookTitle != "" && bookAuthor != "") {
                        // Create a new book to add to the database
                        let newBook = Book(id: "", title: bookTitle, author: bookAuthor, genre: readingListModel.genres[selectedGenre], status: readingListModel.statuses[selectedStatus], pages: Int(bookPages) ?? 0, rating: selectedRating)
                        
                        readingListModel.addBook(book: newBook)
                        
                    }
                } label: {
                    Text("Submit Book")
                }
            }
        }
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
