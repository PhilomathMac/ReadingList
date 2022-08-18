//
//  FullView.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-23.
//

import SwiftUI

struct FullView: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Navigates to the add book form
                NavigationLink(destination: AddBook()) {
                    Text("Add Book")
                }
                
                // Check if list of genres/books exists
                if(readingListModel.genres.count == 0) {
                    Text("No genres/books found")
                }
                
                else {
                    // Diplay each genre and all the books associated with the genre
                    List {
                        ForEach(readingListModel.genres, id: \.self) { genre in
                            GenreSection(genre: genre)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
