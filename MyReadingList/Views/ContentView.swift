//
//  ContentView.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var readingListModel: ReadingListModel
    
    var body: some View {
        TabView {
            FullView()
                .tabItem {
                    Image(systemName: "book")
                    Text("All Books")
                }
            
            GenreView()
                .tabItem {
                    Image(systemName: "folder")
                    Text("Genres")
                }
        }
        
    }
}
