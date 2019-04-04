//
//  Message.swift
//  My Chatter


import Foundation
import RealmSwift

@objcMembers class Message: Object {
    // properties
    dynamic var id = UUID().uuidString
    dynamic var date = Date()
    dynamic var text = ""
    dynamic var from = ""
    dynamic var isNew = true
    
    // initalizer
    convenience init(from: String, text: String) {
        self.init()
        self.from = from
        self.text = text
    }
    
    override static func primaryKey () -> String? {
        return "id"
    }
    
    
}

extension Message {
    public struct properties {
        static let id = "id"
        static let date = "date"
    }
}
