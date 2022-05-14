//
//  DetailView.swift
//  Bookworm
//
//  Created by Gokhan Bozkurt on 14.05.2022.
//

import SwiftUI

struct DetailView: View {
    let book : Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var  showingDeleteAlert = false
    
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            .padding(.bottom)
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            Text(book.review ?? "No Review")
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
                 
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                deleteBook()
            }
            Button("Cancel", role: .cancel) {
            
            }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                self.showingDeleteAlert = true
            } label: {
            Label("Delete this book", systemImage: "trash")
            }
        }
    }


    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

