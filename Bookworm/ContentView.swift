//
//  ContentView.swift
//  Bookworm
//
//  Created by Gokhan Bozkurt on 12.05.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
      //  SortDescriptor(\.title, order: .reverse)
       // SortDescriptor(\.title),
       // SortDescriptor(\.author),
        SortDescriptor(\.rating)
    ]) var books: FetchedResults<Book>
    @State var showingSaveScreen = false
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown")
                                    .font(.headline)
                                    .foregroundColor(book.rating == Int16(1) ? .red : .black)
                                
                                Text(book.author ?? "Unknown")
                                    .foregroundColor(.secondary)
                                
                                Text("\(book.recoderDate?.formatted(date: .complete, time: .shortened) ?? Date.now.formatted(date: .complete, time: .shortened))")
                                
                                    .fontWeight(.light)
                                
                            }
                            
                        }
                    }
                    
                }.onDelete { ieset in
                    deleteBooks(at: ieset)
                }
            }
            .navigationTitle("BookWorm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
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
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
