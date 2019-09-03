//
//  CellSnapshotTestingTests.swift
//  CellSnapshotTestingTests
//
//  Created by Sebastian Osiński on 01/09/2019.
//  Copyright © 2019 Sebastian Osiński. All rights reserved.
//

import FBSnapshotTestCase
@testable import CellSnapshotTesting

class LabelSnapshotTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        
//        recordMode = true
    }
    
    func testSomeView() {
        let view = UIView()
        view.backgroundColor = .green
        view.frame.size = CGSize(width: 100, height: 100)
        
        FBSnapshotVerifyView(view)
    }
    
    func testLabel() {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.text = "ABC\nDEF\nGHI"
        
        label.sizeToFit()
        
        FBSnapshotVerifyView(label)
    }
    
//    func testLabelWithoutNewlines() {
//        let label = UILabel()
//        label.backgroundColor = .white
//        label.numberOfLines = 0
//        label.text = "ABC DEF GHI"
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
//
//        FBSnapshotVerifyView(label)
//    }
    
    func testLabelInContainer() {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.text = "ABC DEF GHI"
        
        let container = SnapshotContainer<UILabel>(label, width: 80)
        
        FBSnapshotVerifyView(container)
    }
}

class SnapshotContainer<View: UIView>: UIView {
    let view: View
    
    init(_ view: View, width: CGFloat) {
        self.view = view
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
