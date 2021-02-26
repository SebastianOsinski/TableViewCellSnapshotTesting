//
//  ViewAssertable.swift
//  CellSnapshotTestingTests
//
//  Created by DMITRY KULAKOV on 26.02.2021.
//  Copyright © 2021 Sebastian Osiński. All rights reserved.
//

import UIKit

protocol ViewAssertable {
    func container() -> UIView
    func viewForAssertion() -> UIView
}

