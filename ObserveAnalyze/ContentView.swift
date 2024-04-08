//
//  ContentView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import SwiftUI

struct ContentView: View {
//	@Environment(Library.self) private var library
	@Environment(Library.self) private var library
	@State private var showingAddBook = false
	@State private var title = ""
	@State private var author = ""
	@State private var bookSelection: Book.ID?

    var body: some View {
        VStack {
			NavigationStack {
				List(library.books, selection: $bookSelection) { book in
					Text(book.id)
				}
			}
        }
        .padding()
		.toolbar {
			Button("Add Book") {
				showingAddBook.toggle()
			}
		}
		.sheet(isPresented: $showingAddBook) {
			AddBookView(showingAddBook: $showingAddBook)
		}
    }
}

#Preview {
    ContentView()
		.environment(Library())
}
