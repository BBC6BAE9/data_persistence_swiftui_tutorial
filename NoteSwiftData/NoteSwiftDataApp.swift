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
    
    @State var noteSearchText:String = ""
    @State var noteSortBy = NoteSortBy.content
    @State var noteOrderBy = OrderBy.descending
    
    
    @State var tagSearchText:String = ""
    @State var tagOrderBy = OrderBy.ascending
    
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
            NoteListView(_allNotes: noteListQuery)
                .searchable(text: $noteSearchText, prompt: "Search")
                .textInputAutocapitalization(.never)
                .navigationTitle("Notes")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Picker("Sort by", selection: $noteSortBy){
                                ForEach(NoteSortBy.allCases){
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteSortBy.text, systemImage:  "line.3.horizontal.decrease.circle")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Sort by", selection: $noteOrderBy){
                                ForEach(OrderBy.allCases){
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteOrderBy.text, systemImage:  "arrow.up.arrow.down")
                        }
                    }
                }
        }
        .tabItem {
            Label("Notes", systemImage: "note")
        }
    }
    
    var noteListQuery:Query<Note, [Note]>{
        let sortOrder:SortOrder = noteOrderBy == .ascending ? .forward :.reverse
        var predicate:Predicate<Note>?
        
        // 查找包含搜索文字的所有note
        if !noteSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            predicate = .init(#Predicate{
                $0.content.contains(noteSearchText)})
        }
        
        // 将查找出来的所有Note进行排序
        if noteSortBy == .content{
            return Query(filter: predicate, sort: \.content, order: sortOrder)
        }else{
            return Query(filter: predicate, sort: \.createAt, order: sortOrder)
        }
    }
    
    var tagListQuery:Query<Tag, [Tag]>{
        let sortOrder:SortOrder = tagOrderBy == .ascending ? .forward :.reverse
        var predicate:Predicate<Tag>?
        
        // 查找包含搜索文字的所有note
        if !tagSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            predicate = .init(#Predicate{
                $0.name.contains(tagSearchText)})
        }
        return Query(filter: predicate, sort: \.name, order: sortOrder)
    }
    
    var tagListView:some View{
        NavigationStack{
            TagListView(_allTags: tagListQuery)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Sort by", selection: $tagOrderBy){
                                ForEach(OrderBy.allCases){
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(tagOrderBy.text, systemImage:  "arrow.up.arrow.down")
                        }
                    }
                }
                .navigationTitle("Tags")
        }
        .tabItem {
            Label("Tags", systemImage: "tag")
        }
    }
}
