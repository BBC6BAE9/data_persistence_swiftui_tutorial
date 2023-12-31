//
//  TagListView.swift
//  NoteSwiftData
//
//  Created by ihenry on 2023/9/13.
//

import SwiftUI
import SwiftData

struct TagListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Tag.name, order: .forward) var allTags:[Tag]
    @State var tagText = ""
    
    var body: some View {
        List {
            Section{
                DisclosureGroup("create a tag") {
                    TextField("Enter Tag", text: $tagText, axis: .vertical)
                        .lineLimit(2...4)
                    
                    Button("save") {
                        createTag()
                    }
                    .disabled(tagText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            
            Section {
                if allTags.isEmpty {
                    ContentUnavailableView("You don't have any tags yet", systemImage: "tag")
                }else{
                    ForEach(allTags){ tag in
                        if let notes = tag.notes, notes.count > 0 {
                            DisclosureGroup("\(tag.name) (\(notes.count))"){
                                ForEach(notes){ note in
                                    Text(note.content)
                                }
                                .onDelete { indexSet in
                                    indexSet.forEach { index in
                                        context.delete(notes[index])
                                    }
                                    try? context.save()
                                }
                            }
                        }else{
                            Text(tag.name)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allTags[index])
                            try? context.save()
                        }
                    }
                }
            }
        }
    }
    
    // 创建一个标签
    func createTag() {
        let tag = Tag(id: UUID().uuidString, name: tagText, notes: [])
        context.insert(tag)
        try? context.save()
        tagText = ""
    }
}

#Preview {
    TagListView()
}
