//
//  ContentView.swift
//  TodoListServer
//
//  Created by Wasi on 18/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textInput: String = ""
    
    var body: some View {
        VStack {
            if listViewModel.items.isEmpty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            else {
                List {
                    ForEach(listViewModel.items) { e in
                        ListViewItem(item: e, onTap: { item in
                            listViewModel.updateItem(item: item)
                        })
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.white.opacity(0))
                            .padding(0)
                    }
                }
                .listStyle(PlainListStyle())
            }
            
            Button {
                listViewModel.getItems()
            } label: {
                Text("Fetch Data")
            }
            Spacer()
            HStack {
                TextField("Ingresa una tarea", text: $textInput)
                    .padding(.horizontal)
                    .frame(height: 55, alignment: .center)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                Button {
                    if !listViewModel.sendingData {
                        listViewModel.addItem(label: textInput.queryValue)
                    }
                } label: {
                    if listViewModel.sendingData {
                        ProgressView()
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    } else {
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(55)
                    }
                        
                }.frame(width: 55, height: 55)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)

        }
        .background(Color.init(hex: 0xE9E9EF))
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// Para poder cerrar el teclado
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ListViewModel())
    }
}
