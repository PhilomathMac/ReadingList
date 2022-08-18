//
//  MyReadingListApp.swift
//  MyReadingList
//
//  Created by McKenzie Macdonald on 2/14/22.
//

import SwiftUI
import Firebase

@main
struct Reading_List_App: App {
    init() {
        // Set-up Firebase for the app
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ReadingListModel())
        }
    }
}
