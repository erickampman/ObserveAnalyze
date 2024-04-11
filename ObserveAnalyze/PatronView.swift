//
//  PatronView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/11/24.
//

import SwiftUI

struct PatronView: View {
	@Environment(Library.self) private var library
	var patron: Patron
	
	var body: some View {
		VStack {
			Text(patron.id)
				.font(.title)
			Text("Books Checked Out")
				.font(.title3)
				.underline()
		}
		ForEach( library.booksCheckedOutByPatron(patron.id)) { book in
			Text(book.id)
		}
	}
}

#Preview {
	let library = Library()
	@State var patron = Patron(name: "Todd Rundgren")

	return PatronView(patron: patron)
		.environment(library)
}
