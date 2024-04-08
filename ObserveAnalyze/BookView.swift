//
//  BookView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import SwiftUI

struct BookView: View {
	var book: Book
    var body: some View {
		VStack {
			HStack {
				Text("Title:")
				Text("\(book.title)")
			}
			HStack {
				Text("Author:")
				Text("\(book.author)")
			}
		}
    }
}

#Preview {
	BookView(book: Book(author: "Fred Johnson", title: "My First Book"))
}
