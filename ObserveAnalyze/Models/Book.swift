//
//  Book.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import Foundation
import Observation

class Book: Identifiable, Equatable {
	@ObservationTracked
	var author = ""
	@ObservationTracked
	var title = ""
	@ObservationTracked
	var patronID = Patron.ID?.none
	
	var id: String {
		return String("\(title): \(author)")
	}
	
	static func == (lhs: Book, rhs: Book) -> Bool {
		lhs.id == rhs.id
	}

	// In ObserveAnalyze2 the below is automatically added for @ObservationTracked.
	// I had to add it manually here.
	@ObservationIgnored private  var _author  = ""
	@ObservationIgnored private  var _title  = ""
	@ObservationIgnored private  var _patronID  = Patron.ID?.none
	
	init(author: String = "", title: String = "") {
		self.author = author
		self.title = title
	}
	
	func setPatron(_ patronID: Patron.ID?) {
		// FIXME what about already checked out?
		self.patronID = patronID
	}
	@ObservationIgnored private let _$observationRegistrar = Observation.ObservationRegistrar()
	
	internal nonisolated func access<Member>(
		keyPath: KeyPath<Book, Member>
	) {
		_$observationRegistrar.access(self, keyPath: keyPath)
	}
	
	internal nonisolated func withMutation<Member, MutationResult>(
		keyPath: KeyPath<Book, Member>,
		_ mutation: () throws -> MutationResult
	) rethrows -> MutationResult {
		try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
	}
}

extension Book: Observation.Observable {
}
