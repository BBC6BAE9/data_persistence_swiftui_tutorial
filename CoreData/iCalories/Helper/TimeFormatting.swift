//
//  TimeFormatting.swift
//  iCalories
//
//  Created by henry on 2023/9/18.
//

import Foundation


/// 转化时间
func calTimeSince(date:Date) -> String {
    let minutes = Int(date.timeIntervalSince1970) / 60
    let hours = minutes / 60
    let days = hours / 24
    
    if minutes < 120 {
        return "\(minutes) minutes ago"
    }else if minutes > 120 && hours < 48{
        return "\(hours) hours ago"
    }else{
        return "\(days) days ago"
    }
}

