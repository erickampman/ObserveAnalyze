//
//  OANavigationSplitView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/11/24.
//

import SwiftUI

struct OANavigationSplitView: View {
	@Environment(Library.self) private var library
	@State private var bookSelection: Book.ID?
	@State private var patronSelection: Patron.ID?
	@State private var showingEditBook = false
	@State private var showingCheckout = false
	@State private var showingAddBook = false
	@State private var showingAddPatron = false

	var body: some View {
		NavigationSplitView {
			GeometryReader { outerGP in
				VStack {
					HStack {
						Text("Books")
						Button("Add") {
							showingAddBook.toggle()
						}
						Button("Edit Book") {
							showingEditBook.toggle()
						}
						.disabled(bookSelection == nil)
						Button("Checkout") {
							showingCheckout.toggle()
						}
						.disabled(bookSelection == nil)
					}
						.font(.title3)
					GeometryReader { gp in
						ScrollView(.vertical) {
							List(library.books, selection: $bookSelection) { book in
								Text(book.id)
							}
							.frame(height: abs(outerGP.frame(in: CoordinateSpace.local).height) / 2.0 - 10.0)
							.onChange(of: bookSelection) {
								if bookSelection != nil {
									patronSelection = nil
								}
							}
						}
					}
					.padding()
					HStack {
						Text("Patrons")
							.font(.title3)
						Button("Add") {
							showingAddPatron.toggle()
						}
					}
					GeometryReader { gp in
						ScrollView(.vertical) {
							List(library.patrons, selection: $patronSelection) { patron in
								Text(patron.id)
							}
							.frame(height: abs(outerGP.frame(in: CoordinateSpace.local).height) / 2.0 - 10.0)
							.onChange(of: patronSelection) {
								if patronSelection != nil {
									bookSelection = nil
								}
							}

						}
					}
					.padding()
				}
				.sheet(isPresented: $showingCheckout) {
					CheckoutView(book: selectedBook()!, showing: $showingCheckout)
				}
				.sheet(isPresented: $showingAddBook) {
					AddBookView(showingAddBook: $showingAddBook)
				}
				.sheet(isPresented: $showingEditBook) {
					EditBookView(book: selectedBook()!, showingEditBook: $showingEditBook)
				}
				.sheet(isPresented: $showingAddPatron) {
					AddPatronView(showing: $showingAddPatron)
				}
			}
			.frame(minHeight: 60)

		} detail: {
			if bookSelection != nil {
				BookView(book: selectedBook()!)
			} else if patronSelection != nil {
				PatronView(patron: selectedPatron()!)
			}
		}
	}
		  
	func selectedBook() -> Book? {
		guard let selection = bookSelection else { return nil }
		let ret = library.books.first { book in
			book.id == selection
		}
		return ret
	}
	
	func selectedPatron() -> Patron? {
		guard let selection = patronSelection else { return nil }
		let ret = library.patrons.first { patron in
			patron.id == selection
		}
		return ret
	}

}
#Preview {
    OANavigationSplitView()
}
