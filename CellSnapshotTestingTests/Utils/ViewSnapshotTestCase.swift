//
//  ViewSnapshotTestCase.swift
//  CellSnapshotTestingTests
//
//  Created by DMITRY KULAKOV on 26.02.2021.
//  Copyright © 2021 Sebastian Osiński. All rights reserved.
//

import FBSnapshotTestCase

open class ViewSnapshotTestCase: FBSnapshotTestCase {

    func assertView(_ view: UIView,
                    identifier: String? = nil,
                    perPixelTolerance: CGFloat = 0,
                    overallTolerance: CGFloat = 0,
                    file: StaticString = #file,
                    line: UInt = #line) {
        autoreleasepool {
            FBSnapshotVerifyView(view,
                                 identifier: identifier,
                                 perPixelTolerance: perPixelTolerance,
                                 overallTolerance: overallTolerance,
                                 file: file, line: line)
        }
    }

    func assertView(_ view: ViewAssertable,
                    identifier: String? = nil,
                    file: StaticString = #file, line: UInt = #line) {
        renderView(view.container()) {
            assertView(view.viewForAssertion(),
                       identifier: identifier,
                       perPixelTolerance: 0,
                       overallTolerance: 0,
                       file: file,
                       line: line)
        }
    }

    func assertViewWithExpectation(_ view: ViewAssertable,
                                   identifier: String? = nil,
                                   timeout: TimeInterval = 0.3,
                                   file: StaticString = #file, line: UInt = #line) {
        renderView(view.container()) {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: timeout))
            assertView(view.viewForAssertion(), identifier: identifier, file: file, line: line)
        }
    }

    func renderView(_ view: UIView, completion: () -> Void) {
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        window.makeKeyAndVisible()
        window.addSubview(view)
        view.layoutIfNeeded()
        completion()
        view.removeFromSuperview()
    }
}
