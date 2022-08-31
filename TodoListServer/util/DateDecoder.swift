//
//  DataDecoder.swift
//  TodoListServer
//
//  Created by Wasi on 29/08/22.
//

import Foundation

final class DateDecoder: JSONDecoder {
    
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        // 2022-08-29 22:34:31.499177
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
