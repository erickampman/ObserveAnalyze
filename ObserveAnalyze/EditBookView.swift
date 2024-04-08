//
//  EditBookView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import SwiftUI

struct EditBookView: View {
	@Bindable var book: Book
	@Binding var showing: Bool
	@State private var title: String
	@State private var author: String
	
	init(book: Book, showingEditBook: Binding<Bool>) {
		self.book = book
		self._showing = showingEditBook
		self.title = book.title
		self.author = book.author
	}
	
	var body: some View {
		VStack {
			Form {
				Section(header: Text("Add Book")) {
					TextField("Title", text: $title)
					TextField("Author", text: $author)
				}
				.frame(minWidth: 200)
			}
			HStack {
				Button("Save") {
					book.author = author
					book.title = title
					showing = false
					title = ""
					author = ""
				}
				Button("Cancel") {
					showing = false
					title = ""
					author = ""
				}
			}
		}
		.padding()
	}
}

#Preview {
	@State var book = Book(author: "Foo", title: "Bar")
	@State var showingEditBook = true
	return EditBookView(book: book, showingEditBook: $showingEditBook)
}
