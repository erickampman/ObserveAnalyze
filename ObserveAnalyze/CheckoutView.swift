//
//  CheckoutView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/9/24.
//

import SwiftUI

struct CheckoutView: View {
	@Environment(Library.self) private var library
	@Bindable var book: Book
	@Binding var showing: Bool
	@State private var selectedPatron: Patron.ID?
	
	init(book: Book, showing: Binding<Bool>) {
		self.book = book
		_showing = showing
		self._selectedPatron = State(initialValue: book.patronID)
	}

	var body: some View {
		VStack {
			Picker("Patron", selection: $selectedPatron) {
				Text("Not Checked out").tag(nil as String?)
				ForEach(library.patrons) { patron in
					Text("\(patron.id)")
						.tag(patron.id as String?)
				}
			}
			HStack {
				Button("Save") {
					book.setPatron(selectedPatron)
					showing = false
				}
				Button("Cancel") {
					showing = false
				}
			}
		}
		.padding()
	}
}

#Preview {
	let book = Book(author: "Fred", title: "Fred's Book")
	@State var showing = true
	return CheckoutView(book: book, showing: $showing)
}
