//
//  NoteListView.swift
//  NoteSwiftData
//
//  Created by ihenry on 2023/9/12.
//

import SwiftUI 
import SwiftData

struct NoteListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \.createAt, order: .reverse) var allNotes:[Note]
    @Query(sort: \.name, order: .forward) var allTags:[Tag]

    @State var noteText = ""
    
    var body: some View {
        List {
            Section{
                DisclosureGroup("create a note") {
                    TextField("Enter Text", text: $noteText, axis: .vertical)
                        .lineLimit(2...4)
                    DisclosureGroup("Tag with") {
                        if allTags.isEmpty{
                            Text("You don't have any tags yet, Please create one from Tags tab")
                                .foregroundStyle(.gray)
                        }
                        
                        ForEach(allTags){ tag in
                            HStack{
                                Text(tag.name)
                                if tag.isChecked{
                                    Spacer()
                                    Image(systemName: "checkmark.circle")
                                        .symbolRenderingMode(.multicolor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                tag.isChecked.toggle()
                            }
                        }
                    }
                    Button("save") {
                        createNote()
                    }
                }
            }
            
            Section {
                if allNotes.isEmpty {
                    ContentUnavailableView("You don't have any notes yet", systemImage: "note.text")
                }else{
                    ForEach(allNotes){ note in
                        VStack(alignment: .leading, content: {
                            Text(note.content)
                            if (note.tags.count > 0){
                                Text("Tags:" + note.tags.map({$0.name}).joined(separator: ","))
                                    .font(.caption)
                            }
                            Text(note.createAt, style: .time)
                                .font(.caption)
                        })
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allNotes[index])
                            try? context.save()
                        }
                    }
                }
            }
        }
        
    }
    
    // 创建一个笔记
    func createNote() {
        var tags = [Tag]()
        
        allTags.forEach { tag in
            if tag.isChecked {
                tags.append(tag)
                tag.isChecked = false
            }
        }
        let note = Note(id: UUID().uuidString, content: noteText, createAt: .now, tags:tags)
        context.insert(note)
        try? context.save()
        noteText = ""
    }
}

#Preview {
    NoteListView()
}
