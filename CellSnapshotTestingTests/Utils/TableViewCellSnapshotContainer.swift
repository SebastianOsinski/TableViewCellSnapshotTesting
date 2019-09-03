//
//  TableViewCellSnapshotContainer.swift
//  CellSnapshotTestingTests
//
//  Created by Sebastian Osiński on 01/09/2019.
//  Copyright © 2019 Sebastian Osiński. All rights reserved.
//

import UIKit

/// Container view which helps snapshot testing single tableView cells.
final class TableViewCellSnapshotContainer<Cell: UITableViewCell>: UIView, UITableViewDataSource, UITableViewDelegate {
    typealias CellConfigurator = (_ cell: Cell) -> ()
    typealias HeightResolver = ((_ width: CGFloat) -> (CGFloat))

    private let tableView = SnapshotTableView()
    private let configureCell: (Cell) -> ()
    private let heightForWidth: ((CGFloat) -> CGFloat)?
    
    /// Initializes container view for cell testing.
    ///
    /// - Parameters:
    ///   - width: Width of cell
    ///   - configureCell: closure which is passed to `tableView:cellForRowAt:` method to configure cell with content.
    ///   - cell: Instance of `Cell` dequeued in `tableView:cellForRowAt:`
    ///   - heightForWidth: closure which is passed to `tableView:heightForRowAt:` method to determine cell's height. When `nil` then `UITableView.automaticDimension` is used as cell's height. Defaults to `nil`.
    init(width: CGFloat, configureCell: @escaping CellConfigurator, heightForWidth: HeightResolver? = nil) {
        self.configureCell = configureCell
        self.heightForWidth = heightForWidth
        
        super.init(frame: .zero)
        
        // Setup tableView to not display anything else besides provided cell (no separators, no footer)
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            widthAnchor.constraint(equalToConstant: width), // constrain container width to provied width
            heightAnchor.constraint(greaterThanOrEqualToConstant: 1.0) // needed for container to grow according to tableView size
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        configureCell(cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForWidth?(frame.width) ?? UITableView.automaticDimension
    }
}

/// `UITableView` subclass for snapshot testing. Automatically resizes to its content size.
final class SnapshotTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            // Trigger intrinsic content size invalidation when content size changes
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        // Layout view again after intrinsic content size changes again
        layoutIfNeeded()
        
        // width is defined by container's width, height should be same as content height (cell's height)
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
