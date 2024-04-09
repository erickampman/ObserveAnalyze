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

