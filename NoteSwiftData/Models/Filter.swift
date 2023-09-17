//
//  Filter.swift
//  NoteSwiftData
//
//  Created by henry on 2023/9/17.
//

import Foundation

 
enum NoteSortBy:Identifiable, CaseIterable{
    var id: Self {self}
    case craetAt // 按照创建时间排序
    case content // 按照内容排序
    
    var text:String {
        switch self {
        case .craetAt:
            "craet at"
        case .content:
            "content"
        }
    }
}


enum OrderBy: Identifiable, CaseIterable {
    var id: Self {self}
     
    case ascending
    case descending

    var text:String {
        switch self {
        case .ascending:
            "ascending"
        case .descending:
            "descending"
        }
    }
    
}
