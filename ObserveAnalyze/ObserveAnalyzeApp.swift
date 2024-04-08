//
//  ObserveAnalyzeApp.swift
//  ObserveAnalyze
//
//  Created by Eric Kampman on 4/8/24.
//

import SwiftUI

@main
struct ObserveAnalyzeApp: App {
	@State private var library = Library()
		
	var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(library)
        }
    }
}
