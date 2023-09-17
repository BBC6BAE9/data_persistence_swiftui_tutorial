//
//  NoteSwiftDataApp.swift
//  NoteSwiftData
//
//  Created by ihenry on 2023/9/12.
//

import SwiftUI
import SwiftData

@main
struct NoteSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                noteListView
                tagListView
            }
            .modelContainer(for:[
                Note.self,
                Tag.self,
            ])
        }
    }
    
    var noteListView:some View{
        NavigationStack{
            NoteListView()
                .navigationTitle("Notes")
        }
        .tabItem {
            Label("Notes", systemImage: "note")
        }
    }
    
    var tagListView:some View{
        NavigationStack{
            TagListView()
                .navigationTitle("Tags")
        }
        .tabItem {
            Label("Tags", systemImage: "tag")
        }
    }
}
