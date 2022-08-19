//
//  TodoListServerApp.swift
//  TodoListServer
//
//  Created by Wasi on 18/08/22.
//

import SwiftUI

@main
struct TodoListServerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ListViewModel())
        }
    }
}
