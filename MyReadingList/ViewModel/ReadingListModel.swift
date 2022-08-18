//
//  ReadingListModel.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-23.
//

import Foundation
import Firebase

class ReadingListModel: ObservableObject {
    // Variables to temporarily store the genres and books information from the database
    @Published var genres : [String] = []
    // Dictionary to match Genres to an array of Books
    @Published var books : [String: [Book]] = [:]
    
    @Published var statuses : [String] = ["Plan to read", "Reading", "On hold", "Completed"]
    
    // Binding for navigation
    @Published var currentBookSelected : Int?

    init() {
        getGenres()
    }
    
    // TODO: Complete all Firestore functions
    /// Adds a document with auto-genrated ID to the books collection in the Firestore database
    ///
    /// Parameters:
    ///     - book: The book to add to the database
    func addBook(book: Book) {
        
        let database = Firestore.firestore()
        
        database.collection("books").document().setData(["title" : book.title, "author" : book.author, "pages" : book.pages, "rating" : book.rating, "genre" : book.genre, "status" : book.status])
        
    }
    
    /// Deletes a specific book document in the books collection in the Firestore database
    ///
    /// Parameters:
    ///     - book: The book to delete in  the database
    func deleteBook(book: Book) {
        
        let database = Firestore.firestore()
        
        let bookToDelete = database.collection("books").document(book.id)
        
        bookToDelete.delete()
        
    }
    
    /// Updates a book document's genre, status, and rating fields, in the books collection in the Firestore database
    ///
    /// Parameters:
    ///     - book: The book to update in the database
    func updateBookData(book: Book) {
        
        let database = Firestore.firestore()
        let books = database.collection("books")
        let bookToUpdate = books.document(book.id)
        
        bookToUpdate.updateData(["rating" : book.rating, "status" : book.status, "genre" : book.genre])
        
        
    }
    
    /// Queries the books collection in the Firestore database and finds all book documents with the matching "genre" field value. Updates the "books" class field with the queried book documents' data
    ///
    /// Parameters:
    ///     - genre: The genre to match when querying the book documents
    func getBooksByGenre(genre: String) {
        
        let database = Firestore.firestore()
        let books = database.collection("books")
        
        let query = books.whereField("genre", isEqualTo: genre)
        
        query.getDocuments { querySnapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            else if let snapShot = querySnapshot {
                
                var allBooks = [Book]()
                
                for doc in snapShot.documents {
                    
                    let data = doc.data()
                    let id = doc.documentID
                    let title = data["title"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let genre = data["genre"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let pages = data["pages"] as? Int ?? 0
                    let rating = data["rating"] as? Int ?? 0
                    
                    allBooks.append(Book(id: id, title: title, author: author, genre: genre, status: status, pages: pages, rating: rating))
                    
                }
                
                self.books[genre] = allBooks
                
            }
            else {
                print("Snapshot not created")
            }
            
        }
        
        
    }

    /// Adds a genre document with the genre as the document ID to the genres collection
    ///
    /// Parameters:
    ///     - genre: The name of the genre to add to the Firestore database
    func addGenre(genre: String) {
        
        let database = Firestore.firestore()
        
        let genres = database.collection("genres")
        
        genres.document(genre).setData([:])
        
    }
    
    /// Gets all genre documents in the genres collection in the Firestore database and updates the "genres" class field with the genre document ID names.
    ///
    /// Parameters:
    ///     - genre: The genre to match when querying the book documents
    func getGenres() {
        
        let database = Firestore.firestore()
        
        database.collection("genres").getDocuments { querySnapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            else if let snapShot = querySnapshot {
                var allGenres = [String]()
                // Get all the genres
                for doc in snapShot.documents {
                    let genreName = String(doc.documentID)
                    allGenres.append(genreName)
                }
                self.genres = allGenres
            }
            else {
                print("Snapshot not created")
            }
        } // End query
        
    } // End getGenres
    
}
