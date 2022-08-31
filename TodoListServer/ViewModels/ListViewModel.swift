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
        client.database.from("tasks").select().order(column: "created_at", ascending: true).execute { results in
            switch results {
            case let .success(response):
                print("Success")
                print(String.init(data: response.data, encoding: .utf8))
                
                do {
                    let data = try response.decoded(to: [Task].self, using: DateDecoder())
                    
                    
                    // Necesario para que se asigne desde el hilo principal
                    DispatchQueue.main.async {
//                        if let tasks = data {
                            self.items = data
//                        }
                    }
                } catch {
                    print("Error decoding data \(error)")
                }
                
            case let .failure(error):
                print("Error")
                print(error)
            }
        }
    }
    
    func addItem(label: String) {
        let item = Task(id: nil, label: label, isCompleted: false, createdAt: .now)
        
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
    
    func updateItem(item: Task) {
        
        client.database.from("tasks").update(values: item.updateCompletion()).execute { results in
            switch results {
            case let .success(res):
                print("====== SUCCESS UPDATE =======")
                print(res)
                print(String.init(data: res.data, encoding: .utf8));
                if let index = self.items.firstIndex(where: {$0.id == item.id}) {
                    self.items[index] = item.updateCompletion()
                }
            case let .failure(err):
                print("====== ERROR UPDATE =======")
                print(err)
            }
        }
    }
}
