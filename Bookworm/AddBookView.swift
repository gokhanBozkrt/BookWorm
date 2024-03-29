//
//  AddBookView.swift
//  Bookworm
//
//  Created by Gokhan Bozkurt on 13.05.2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Mystery"
    @State private var review = ""
    
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Book Name", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id:\.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    /*
                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6) {
                            Text(String($0))
                        }
                    }
                    */
                } header: {
                    Text("Write a review")
                }
                .headerProminence(.increased)
                Section {
                    Button("Save the Book") {
                        // Add book
                      let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        newBook.recoderDate = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                }.disabled( sectionWordChecker() == false)
            }
            .navigationTitle("Add Book")
        }
    }
    func sectionWordChecker() -> Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  {
            return false
        }
        return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
