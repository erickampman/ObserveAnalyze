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
	@State private var showingEditBook = false
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
			Button("Edit Book") {
				showingEditBook.toggle()
			}
			.disabled(bookSelection == nil)
		}
		.sheet(isPresented: $showingAddBook) {
			AddBookView(showingAddBook: $showingAddBook)
		}
		.sheet(isPresented: $showingEditBook) {
			EditBookView(book: try! bookFromID(bookSelection), showingEditBook: $showingEditBook)
		}
    }
	
	func bookFromID(_ id: Book.ID?) throws -> Book {
		if id == nil { throw OAError.noSelection}
		let book = library.books.first { book in
			book.id == id
		}
		if book == nil { throw OAError.notFound}
		return book!
	}

}

#Preview {
    ContentView()
		.environment(Library())
}
