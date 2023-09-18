//
//  Note.swift
//  NoteSwiftData
//
//  Created by ihenry on 2023/9/12.
//

import Foundation
import SwiftData

@Model
class Note{
  
    var id: String?
    var content: String = ""
    var createAt: Date = Date()
    
    @Relationship(inverse:\Tag.notes) var tags: [Tag]?
    
    init(id: String, content: String, createAt: Date, tags: [Tag]) {
        self.id = id
        self.content = content
        self.createAt = createAt
        self.tags = tags
    }

}
