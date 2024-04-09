//
//  Book.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import Foundation
import Observation

class Book: Identifiable, Equatable {
	var author: String = ""
	{
		@storageRestrictions(initializes: _author )
		init(initialValue) {
		  _author  = initialValue
		}
		get {
		  access(keyPath: \.author )
		  return _author
		}
		set {
		  withMutation(keyPath: \.author ) {
			_author  = newValue
		  }
		}
	}
	@ObservationIgnored private  var _author  = ""

	var title: String = ""
	{
		@storageRestrictions(initializes: _title )
		init(initialValue) {
		  _title  = initialValue
		}
		get {
		  access(keyPath: \.title )
		  return _title
		}
		set {
		  withMutation(keyPath: \.title ) {
			_title  = newValue
		  }
		}
	}
	@ObservationIgnored private  var _title  = ""
	
	var patronID: Patron.ID? = Patron.ID?.none
	{
		@storageRestrictions(initializes: _patronID )
		init(initialValue) {
		  _patronID  = initialValue
		}
		get {
		  access(keyPath: \.patronID )
		  return _patronID
		}
		set {
		  withMutation(keyPath: \.patronID ) {
			_patronID  = newValue
		  }
		}
	}
	@ObservationIgnored private  var _patronID  = Patron.ID?.none

	var id: String {
		return String("\(title): \(author)")
	}
	
	static func == (lhs: Book, rhs: Book) -> Bool {
		lhs.id == rhs.id
	}

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
