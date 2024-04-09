//
//  Patron.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/9/24.
//

import Foundation

class Patron: Equatable, Identifiable {
	static func == (lhs: Patron, rhs: Patron) -> Bool {
		lhs.id == rhs.id
	}
	
	@ObservationTracked
	var name: String
	@ObservationIgnored private  var _name: String
	var id: String {
		return name
	}
	
	init(name: String) {
		self.name = name
	}
	
	@ObservationIgnored private let _$observationRegistrar = Observation.ObservationRegistrar()

	internal nonisolated func access<Member>(
		keyPath: KeyPath<Patron, Member>
	) {
	  _$observationRegistrar.access(self, keyPath: keyPath)
	}

	internal nonisolated func withMutation<Member, MutationResult>(
	  keyPath: KeyPath<Patron, Member>,
	  _ mutation: () throws -> MutationResult
	) rethrows -> MutationResult {
	  try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
	}
}

extension Patron: Observation.Observable {
}
