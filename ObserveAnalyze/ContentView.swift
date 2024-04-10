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
	@State private var showingAddPatron = false
	@State private var showingCheckout = false
	@State private var title = ""
	@State private var author = ""
	@State private var bookSelection: Book.ID?
	
	@State private var doSplitView = true

	var body: some View {
		if doSplitView {
			
		} else {
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
				Text("•")
				Button("Add Patron") {
					showingAddPatron.toggle()
				}
				Button("Checkout") {
					showingCheckout.toggle()
				}
				.disabled(bookSelection == nil)
				
			}
			.sheet(isPresented: $showingAddBook) {
				AddBookView(showingAddBook: $showingAddBook)
			}
			.sheet(isPresented: $showingEditBook) {
				EditBookView(book: try! bookFromID(bookSelection), showingEditBook: $showingEditBook)
			}
			.sheet(isPresented: $showingAddPatron) {
				AddPatronView(showing: $showingAddPatron)
			}
			.sheet(isPresented: $showingCheckout) {
				CheckoutView(book: try! bookFromID(bookSelection), showing: $showingCheckout)
			}
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
