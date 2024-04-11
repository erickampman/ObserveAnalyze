//
//  Library.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import Foundation

class Library {
	@ObservationTracked
	var books = [Book(author: "The Author", title: "The Title"),
				 Book(author: "Another Author", title: "Another Title")
	]
	
	@ObservationTracked
	var patrons = [Patron(name: "Todd Rundgren"),
				   Patron(name: "Kevin Gilbert")
	]
	@ObservationIgnored private  var _patrons  = [Patron(name: "Todd Rundgren"),
												  Patron(name: "Kevin Gilbert")
	]
	
	func bookFromID(_ id: Book.ID) -> Book? {
		return self.books.first { book in
			book.id == id
		}
	}
	
	func patronFromID(_ id: Patron.ID) -> Patron? {
		return self.patrons.first { patron in
			patron.id == id
		}
	}

	/*
		In the real world this would be the wrong way to
		go about it, given how likely the set of all books
		in a library there would be.
		
		A reasonable solution might be to track a patron's
		set of checked out books in the patron itself.
	 
		FIXME
	 */
	func booksCheckedOutByPatron(_ id: Patron.ID) -> [Book] {
		var ret = [Book]()
		
		for book in books {
			if book.patronID == id {
				ret.append(book)
			}
		}
		return ret
	}
	
	func checkedOutTo(_ book: Book) -> Patron.ID? {
		guard let id = book.patronID else {
			return nil
		}
		guard let patron = self.patronFromID(id) else {
			return nil // probably an error
		}
		return patron.id
	}
	
	func checkedOutDescription(_ book: Book) -> String {
		guard let id = checkedOutTo(book) else {
			return "<<Available>>"
		}
		guard let patron = self.patronFromID(id) else {
			return "<<Available>>"	// actually an error FIXME
		}
		return patron.id
	}

	
	// In ObserveAnalyze2 the below is automatically added for @ObservationTracked.
	// I had to add it manually here. 
	@ObservationIgnored private var _books = [Book(author: "The Author", title: "The Title"),
											  Book(author: "Another Author", title: "Another Title")
	]
	
	@ObservationIgnored private let _$observationRegistrar = Observation.ObservationRegistrar()
	
	internal nonisolated func access<Member>(
		keyPath: KeyPath<Library, Member>
	) {
		_$observationRegistrar.access(self, keyPath: keyPath)
	}
	
	internal nonisolated func withMutation<Member, MutationResult>(
		keyPath: KeyPath<Library, Member>,
		_ mutation: () throws -> MutationResult
	) rethrows -> MutationResult {
		try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
	}
}
extension Library: Observation.Observable {
}

