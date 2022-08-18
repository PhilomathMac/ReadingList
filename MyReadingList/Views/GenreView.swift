//
//  GenreView.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-23.
//

import SwiftUI

struct GenreView: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    @State var newGenre = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Text box to type new genre name
                TextField("New genre", text: $newGenre)
                    .multilineTextAlignment(.center)
                
                // Button to add new genre to the database
                Button {
                    // Check if genre name is blank
                    if(newGenre != "") {
                        readingListModel.addGenre(genre: newGenre)
                        
                        // Fetch new genre data from the database
                        readingListModel.getGenres()
                        newGenre = ""
                    }
                } label: {
                    Text("Add Genre")
                        .padding(.bottom, 50)
                }
                
                // Check for empty genres list
                if(readingListModel.genres.count == 0) {
                    Text("No genres found. Add a genre to get started")
                }
                else {
                    ScrollView {
                        // Display each genre with tappable navigation to view all books associated with the given genre
                        ForEach(readingListModel.genres, id: \.self) { genre in
                            NavigationLink(destination:
                                            List{
                                                GenreSection(genre: genre)
                                            }) {
                                Text(genre)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}
