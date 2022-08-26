//
//  ListViewItem.swift
//  TodoListServer
//
//  Created by Wasi on 18/08/22.
//

import SwiftUI

struct ListViewItem: View {
    
    let item: Task
    let onTap: (_ item: Task) -> ()
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.leading, 10)
                .foregroundColor(Color.init(hex: item.isCompleted ? 0x018CF0 : 0xEDEEF0))
            Text(item.label)
                .frame(height: 55)
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.top, 0)
        .onTapGesture {
            onTap(item)
        }
    }
}

struct ListViewItem_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(id: nil, label: "Tarea de muestra", isCompleted: true)
        ListViewItem(item: task, onTap: { item in
            print(item)
        })
            .background(Color.init(hex: 0xE9E9EF))
    }
}
