//
//  AddPatronView.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/9/24.
//

import SwiftUI

struct AddPatronView: View {
	@Environment(Library.self) private var library
	@Binding var showing: Bool
	@State var name = ""

	var body: some View {
		VStack {
			Text("# of Patrons: \(library.patrons.count)")
			Form {
				Section(header: Text("Add Patron")) {
					TextField("Name", text: $name)
						.frame(minWidth: 200)
				}
			}
			HStack {
				Button("Add") {
					library.patrons.append(Patron(name: name))
					showing = false
				}
				.disabled(name.isEmpty)
				Button("Cancel") {
					showing = false
				}
			}
		}
		.padding()
	}
}

#Preview {
	@State var showing = true
	return AddPatronView(showing: $showing)
}
