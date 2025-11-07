//
//  Message.swift
//  WA8
//
//  Created by Sai Vihar Reddy Gunamgari on 11/2/25.
//

import Foundation
import FirebaseFirestore

struct Message: Codable, Hashable {
    @DocumentID var id: String?
    var senderId: String
    var senderName: String?
    var text: String
    var timestamp: Timestamp
}

extension Timestamp {
    func formattedTime() -> String {
        let date = self.dateValue()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current

        if calendar.isDateInToday(date) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        } else if let daysAgo = calendar.dateComponents([.day], from: date, to: Date()).day {
            if daysAgo == 1 {
                formatter.dateFormat = "h:mm a"
                return "Yesterday \(formatter.string(from: date))"
            } else if daysAgo < 7 {
                formatter.dateFormat = "EEE h:mm a"
                return formatter.string(from: date)
            }
        }

        formatter.dateFormat = "MM/dd/yy h:mm a"
        return formatter.string(from: date)
    }
}
