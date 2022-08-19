//
//  ListViewModel.swift
//  TodoListServer
//
//  Created by Wasi on 18/08/22.
//

import Foundation
import Supabase

class ListViewModel: ObservableObject {
    
    let client = SupabaseClient(supabaseURL: Constans.url, supabaseKey: Constans.apiKey)
    @Published var items: [Task] = []
    @Published var sendingData = false
    
//    init() {
//        getItems();
//    }
    
    func getItems() {
        print("execute")
        client.database.from("tasks").select().execute { results in
            switch results {
            case let .success(response):
                print("Success")
//                print(String.init(data: response.data, encoding: .utf8))
                let data = try? response.decoded(to: [Task].self)
//                print(data?[0].label)
                
                // Necesario para que se asigne desde el hilo principal
                DispatchQueue.main.async {
                    if let tasks = data {
                        self.items = tasks
                    }
                }
            case let .failure(error):
                print("Error")
                print(error)
            }
        }
    }
    
    func addItem(label: String) {
        let item = Task(id: nil, label: label, isCompleted: false)
        
        sendingData = true
        client.database.from("tasks").insert(values: item).execute { results in
            DispatchQueue.main.async {
                self.sendingData = false
            }
            switch results {
            case let .success(response):
                print("====== SUCCESS ======")
                print(response)
                print(String.init(data: response.data, encoding: .utf8));
            case let .failure(error):
                print("====== ERROR ======")
                print(error)
            }
        }
    
    }
}