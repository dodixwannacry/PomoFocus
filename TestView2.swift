//
//  TestView2.swift
//  PomoFocus
//
//  Created by Davide Formisano on 06/12/23.
//

import SwiftUI

@main
struct AudioPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            TestView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
        }
    }
}
