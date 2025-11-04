//
//  Chat.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import Foundation
import FirebaseFirestore

struct Chat: Codable, Hashable {
    var chatId: String?
    var with: [String]
    var withNames: [String]
    var lastMessage: String?
    var lastSender: String?
    var lastUpdated: Int64?
    
    var lastMsgPreview: String {
        let maxCharacters = 95
        guard let message = lastMessage, !message.isEmpty else {
            return ""
        }
        if message.count > maxCharacters {
            let endIdx = message.index(message.startIndex, offsetBy: maxCharacters)
            return String(message[..<endIdx]) + "..."
        }
        return message
    }
    
    var lastMsgTime: String {
        guard let timestamp = lastUpdated else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp) / 1000)
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        if calendar.isDateInToday(date) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        } else if let daysAgo = calendar.dateComponents([.day], from: date, to: Date()).day {
            if daysAgo == 1 {
                return "Yesterday"
            } else if daysAgo < 7 {
                formatter.dateFormat = "EEE"
                return formatter.string(from: date)
            }
        }
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: date)
    }
}
