//
//  AddBookView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import SwiftUI

struct AddBookView: View {
	@Environment(Library.self) private var library
	@Binding var showingAddBook: Bool
	@State private var title = ""
	@State private var author = ""

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
				Button("Add") {
					let book = Book(author: author, title: title)
					library.books.append(book)
					showingAddBook = false
					title = ""
					author = ""
				}
				Button("Cancel") {
					showingAddBook = false
					title = ""
					author = ""
				}
			}
		}
		.padding()
	}
}

#Preview {
	let library = Library()
	@State var showingAddBook = true
	return AddBookView(showingAddBook: $showingAddBook)
		.environment(library)
}
