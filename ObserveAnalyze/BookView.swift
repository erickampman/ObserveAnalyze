//
//  BookView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import SwiftUI

struct BookView: View {
	@Environment(Library.self) private var library
	var book: Book
    var body: some View {
		VStack {
			Text("Book Detail")
				.font(.title)
			HStack {
				Text("Title:")
				Text("\(book.title)")
			}
			HStack {
				Text("Author:")
				Text("\(book.author)")
			}
			Text("Checked Out To: \(library.checkedOutDescription(book))")
		}
    }
}

#Preview {
	BookView(book: Book(author: "Fred Johnson", title: "My First Book"))
}
