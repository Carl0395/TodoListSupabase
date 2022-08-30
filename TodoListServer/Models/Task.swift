//
//  Task.swift
//  TodoListServer
//
//  Created by Wasi on 18/08/22.
//

import Foundation

struct Task: Identifiable, Codable, Hashable {
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.label == rhs.label && lhs.isCompleted == rhs.isCompleted && lhs.createdAt == rhs.createdAt
    }
    
    let id: String?
    let label: String
    let isCompleted: Bool
    let createdAt: Date?
    
    init(id: String?, label: String, isCompleted: Bool, createdAt: Date?) {
        self.id = id
        self.label = label
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case label
        case isCompleted = "is_completed"
        case createdAt = "created_at"
    }
    
    func updateCompletion() -> Task {
        return Task(id: id, label: label, isCompleted: !isCompleted, createdAt: createdAt)
    }
}
