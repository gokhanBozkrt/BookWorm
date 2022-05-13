//
//  MultiLineText.swift
//  Bookworm
//
//  Created by Gokhan Bozkurt on 12.05.2022.
//

import SwiftUI

struct MultiLineText: View {
   @AppStorage("notes") private var notes = ""
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct MultiLineText_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineText()
    }
}
