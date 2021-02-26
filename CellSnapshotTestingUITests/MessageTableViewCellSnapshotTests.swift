//
//  MessageTableViewCellSnapshotTests.swift
//  CellSnapshotTestingTests
//
//  Created by Sebastian Osiński on 02/09/2019.
//  Copyright © 2019 Sebastian Osiński. All rights reserved.
//

import OwnUIKit
import FBSnapshotTestCase

class MessageTableViewCellSnapshotTests: ViewSnapshotTestCase {
    override func setUp() {
        super.setUp()
        
//        recordMode = true
    }
    
//    func testCellNotWorkingSnapshot() {
//        let cell = MessageTableViewCell(style: .default, reuseIdentifier: nil)
//        cell.label.text = "Message"
//        cell.avatar.backgroundColor = .green
//        
//        let container = SnapshotContainer(cell, width: 375)
//     
//        FBSnapshotVerifyView(container)
//    }
    
    func testCellWithShortText() {
        let container = TableViewCellSnapshotContainer<MessageTableViewCell>(width: 375, configureCell: { cell in
            cell.label.text = "Short message"
            cell.avatar.backgroundColor = .green
        })

        assertView(container)
    }
    
    func testCellWithMultilineText() {
        let container = TableViewCellSnapshotContainer<MessageTableViewCell>(width: 375, configureCell: { cell in
            cell.label.text = "Very long message\nWith multiple lines\nThree\nFour\nFive\nSix"
            cell.avatar.backgroundColor = .green
        })
        
        assertView(container)
    }
}
