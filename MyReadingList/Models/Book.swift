//
//  Books.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-23.
//

import Foundation

// Data structure for books
struct Book: Hashable, Identifiable {
    // ID is the document ID in the Firestore database
    var id: String
    var title: String
    var author: String
    var genre: String
    var status: String
    var pages: Int
    var rating: Int
}
