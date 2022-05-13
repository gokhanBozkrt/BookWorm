//
//  ContentView.swift
//  Bookworm
//
//  Created by Gokhan Bozkurt on 12.05.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    @State var showingSaveScreen = false
    var body: some View {
        NavigationView {
            Text("\(books.count)")
                .navigationTitle("BookWorm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.showingSaveScreen.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                    
                }
                .sheet(isPresented: $showingSaveScreen) {
                    AddBookView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
