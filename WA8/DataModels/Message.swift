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

//extension Int64 {
//    func formattedTime() -> String {
//        let date = Date(timeIntervalSince1970: TimeInterval(self) / 1000)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "hh:mm a"
//        return formatter.string(from: date)
//    }
//}


extension Timestamp {
    func formattedTime() -> String {
        let date = self.dateValue()
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}
