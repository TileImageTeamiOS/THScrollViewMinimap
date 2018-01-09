//
//  MinimapView.swift
//  ScrollViewMinimap
//
//  Created by Seong ho Hong on 2017. 12. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

open class MinimapView: UIView {

    private var dataSource: MinimapDataSource?

    var minimapImageView: UIImageView?
    var focusedBoxView: UIView?

    open func set(dataSource: MinimapDataSource) {
        self.dataSource = dataSource

        minimapImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: dataSource.minimapImageWidth, height: dataSource.minimapImageHeight))
        minimapImageView?.image = dataSource.thumbnailImage
        minimapImageView?.contentMode = .scaleAspectFit

        focusedBoxView = UIView(frame: CGRect(x: 0, y: 0, width: dataSource.minimapImageWidth, height: dataSource.minimapImageHeight))
        focusedBoxView?.layer.borderWidth = dataSource.borderWidth
        focusedBoxView?.layer.borderColor = dataSource.borderColor.cgColor

        self.addSubview(minimapImageView!)
        self.addSubview(focusedBoxView!)

        updateConstraints()
    }

    open override func updateConstraints() {
        super.updateConstraints()
        self.removeConstraints(self.constraints)

        if let dataSource = dataSource {
            self.heightAnchor.constraint(equalToConstant: dataSource.minimapImageHeight).isActive = true
            self.widthAnchor.constraint(equalToConstant: dataSource.minimapImageWidth).isActive = true

            self.trailingAnchor.constraint(equalTo: dataSource.scrollView.trailingAnchor, constant: 50).isActive = true
            self.bottomAnchor.constraint(equalTo: dataSource.scrollView.bottomAnchor, constant: 50).isActive = true
        }
    }
}
