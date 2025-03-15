//
//  AestheticText.swift
//  AestheticText
//
//  Created by Kyle Bashour on 3/15/25.
//

import SwiftUI

extension View {
    /// Wraps text "aesthetically" by compressing the views width to be as small as possible without
    /// affecting the height - in practice, making the length of lines of text as equal as possible.
    ///
    /// The method works best with centered text, as it may cause the second of two lines of text to
    /// to be longer than the first, which can look off with left or right-aligned text.
    public func aestheticText() -> some View {
        modifier(AestheticTextModifier())
    }
}

private struct AestheticTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        AestheticTextLayout() {
            content
        }
    }
}

private struct AestheticTextLayout: Layout {
    func makeCache(subviews: Subviews) -> CGSize? {
        nil
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CGSize?) -> CGSize {
        assert(subviews.count == 1)

        guard let subview = subviews.first else {
            return .zero
        }

        let sizeThatFits = subview.sizeThatFits(proposal)
        let size = smallestSize(for: subview, proposal: proposal, sizeThatFits: sizeThatFits)

        cache = size
        return size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CGSize?) {
        assert(subviews.count == 1)

        guard let subview = subviews.first else {
            return
        }

        let size = cache ?? subview.sizeThatFits(proposal)
        subview.place(at: bounds.origin, proposal: ProposedViewSize(size))
    }

    /// Performs a binary search to find the smallest width, up to a tuned precision,
    /// that does not affect the height (e.g., cause the text to wrap to another line).
    private func smallestSize(for subview: LayoutSubview, proposal: ProposedViewSize, sizeThatFits: CGSize) -> CGSize {
        var maxWidth = sizeThatFits.width
        // It will never make sense to wrap to less than half of the current width.
        var minWidth = maxWidth * 0.5

        // Get within 10% of the smallest possible size based on the range of possible sizes.
        let precision = max(1, (maxWidth - minWidth) * 0.1)
        let naturualHeight = sizeThatFits.height

        while maxWidth - minWidth > precision {
            let midWidth = (minWidth + maxWidth) / 2

            var testProposal = proposal
            testProposal.width = midWidth
            let testSize = subview.sizeThatFits(testProposal)

            if testSize.height == naturualHeight {
                // Shrink further
                maxWidth = midWidth
            } else {
                // Too narrow, increase width
                minWidth = midWidth
            }
        }

        return CGSize(width: maxWidth, height: naturualHeight)
    }
}
