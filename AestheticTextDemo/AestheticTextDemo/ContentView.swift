//
//  ContentView.swift
//  AestheticTextDemo
//
//  Created by Kyle Bashour on 3/17/25.
//

import SwiftUI
import AestheticText

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    Text("This text will be compressed so that lines are as close to equal-length as possible.")
                        .multilineTextAlignment(.center)
                        .aestheticText()
                        .caption(".aestheticText()", alignment: .center)

                    Text("It works great for empty-state views, with centered text.")
                        .multilineTextAlignment(.center)
                        .caption("Default", alignment: .center)

                        Text("It works great for empty-state views, with centered text.")
                            .multilineTextAlignment(.center)
                            .aestheticText()
                            .caption(".aestheticText()", alignment: .center)

                    VStack(alignment: .leading, spacing: 40) {
                        Text("It can sometimes create slightly awkward results for non-centered text.")
                            .caption("Default", alignment: .leading)

                        Text("It can sometimes create slightly awkward results for non-centered text.")
                            .aestheticText()
                            .caption(".aestheticText()", alignment: .leading)
                    }
                }
                .padding()
            }
            .navigationTitle("Aesthetic Text")
        }
    }
}

extension View {
    func caption(_ text: String, alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 10) {
            self

            Text(text)
                .font(.caption)
                .monospaced()
                .bold()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
