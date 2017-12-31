//
//  MinimapView.swift
//  ScrollViewMinimap
//
//  Created by Seong ho Hong on 2017. 12. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

public class MinimapView: UIView {
    fileprivate var dataSource: MinimapDataSource!
    private var imageView = UIImageView()
    private var currentView = UIView()
    
    public func set(dataSource: MinimapDataSource, height: NSLayoutConstraint, width: NSLayoutConstraint) {
        NotificationCenter.default.addObserver(self, selector: #selector(scollViewAction),
                                               name: NSNotification.Name(rawValue: "scollViewAction"),
                                               object: nil)
        
        self.dataSource = dataSource
        height.constant = dataSource.minimapImageHeight
        width.constant = dataSource.minimapImageWidth
        
        imageView.frame = CGRect(x: 0, y: 0, width: dataSource.minimapImageWidth, height: dataSource.minimapImageHeight)
        imageView.image = dataSource.image
        imageView.contentMode = .scaleAspectFit
        
        currentView.frame = CGRect(x: 0, y: 0, width: dataSource.minimapImageWidth, height: dataSource.minimapImageHeight)
        currentView.layer.borderWidth = CGFloat(dataSource.borderWidth)
        currentView.layer.borderColor = dataSource.borderColor

        self.addSubview(imageView)
        self.addSubview(currentView)
    }
    
    @objc func scollViewAction (_ notification: Notification) {
        let rect = scrollViewVisibleSize().divideCGRectByDouble(double: dataSource.ratio)
        currentView.frame = currentCGRect(xDoubel: Double(rect.origin.x), yDouble: Double(rect.origin.y), heightDouble: Double(rect.height), widthDouble: Double(rect.width))
    }
    
    private func currentCGRect(xDoubel: Double, yDouble: Double, heightDouble: Double, widthDouble: Double) -> CGRect {
        var x = xDoubel
        var y = yDouble
        var height = heightDouble
        var width = widthDouble
        
        if x < 0.0 {
            width = width + x
            x = 0.0
        }
        
        if y < 0.0 {
            height = height + y
            y = 0.0
        }
        
        if Double(dataSource.minimapImageHeight) < height {
            height = Double(dataSource.minimapImageHeight)
        } else if y + height > Double(dataSource.minimapImageHeight) {
            height = Double(dataSource.minimapImageHeight) - y
        }
        
        if Double(dataSource.minimapImageWidth) < width {
            width = Double(dataSource.minimapImageWidth)
        } else if x + width > Double(dataSource.minimapImageWidth) {
            width = Double(dataSource.minimapImageWidth) - x
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func scrollViewVisibleSize() -> CGRect {
        let zoomScale = dataSource.scrollViewZoomScale
        
        return CGRect(x: dataSource.scrollViewX/zoomScale,
                      y: dataSource.scrollViewY/zoomScale,
                      width: dataSource.scrollViewWidth/zoomScale,
                      height: dataSource.scrollViewHeight/zoomScale)
    }
}

extension CGRect {
    public func divideCGRectByDouble(double: Double) -> CGRect {
        return CGRect(x: Double(self.origin.x)/double,
                      y: Double(self.origin.y)/double,
                      width: Double(self.width)/double,
                      height: Double(self.height)/double)
    }
}
