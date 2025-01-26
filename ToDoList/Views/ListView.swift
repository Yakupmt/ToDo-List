//
//  ListView.swift
//  ToDoList
//
//  Created by yakup metin on 25.01.2025.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty{
                NoItemsView()
                    .transition(AnyTransition.opacity
                        .animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(Image("moon2"))
        .opacity(0.78)
        .navigationTitle("To Do List ☾")
        .foregroundColor(.black)
        .bold()
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("add", destination: AddView())
        )
    }
    
}

struct ListView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
