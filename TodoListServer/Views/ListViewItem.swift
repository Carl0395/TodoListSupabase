//
//  ListViewItem.swift
//  TodoListServer
//
//  Created by Wasi on 18/08/22.
//

import SwiftUI

struct ListViewItem: View {
    
    let item: Task
    
    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.leading, 10)
                .foregroundColor(Color.init(hex: 0xEDEEF0))
            Text(item.label)
                .frame(height: 55)
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.top, 5)
    }
}

struct ListViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ListViewItem(item: Task(id: nil, label: "Tarea de muestra", isCompleted: false))
            .background(Color.init(hex: 0xE9E9EF))
    }
}
