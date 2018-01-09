//
//  MinimapDataSource.swift
//  ScrollViewMinimap
//
//  Created by 홍창남 on 2018. 1. 9..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit


public protocol MinimapDataSource {
    var scrollView: UIScrollView { get }
    var thumbnailImage: UIImage { get }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor { get set }
    var downSizeRatio: CGFloat { get set }

    func resizeMinimapView(minimapView: MinimapView)
}


extension MinimapDataSource {
    public var minimapImageHeight: CGFloat {
        return (thumbnailImage.size.height)/downSizeRatio
    }

    public var minimapImageWidth: CGFloat {
        return (thumbnailImage.size.width)/downSizeRatio
    }

    var scrollViewVisibleSize: CGRect {

        let zoomScale = scrollView.zoomScale

        let scrollViewX = scrollView.contentOffset.x
        let scrollViewY = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.bounds.size.height
        let scrollViewWidth = scrollView.bounds.size.width

        return CGRect(x: scrollViewX/zoomScale, y: scrollViewY/zoomScale,
                      width: scrollViewWidth/zoomScale, height: scrollViewHeight/zoomScale)
    }

    func currentRect(rect: CGRect) -> CGRect {
        var x = rect.origin.x
        var y = rect.origin.y
        var width = rect.size.width
        var height = rect.size.height

        if x < 0.0 {
            width += x
            x = 0.0
        }

        if y < 0.0 {
            height += y
            y = 0.0
        }

        if self.minimapImageHeight < height {
            height = self.minimapImageHeight
        } else if y + height > self.minimapImageHeight {
            height = self.minimapImageHeight - y
        }

        if self.minimapImageWidth < width {
            width = self.minimapImageWidth
        } else if x + width > self.minimapImageWidth {
            width = self.minimapImageWidth - x
        }
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

extension CGRect {
    public func divideCGRectByDouble(ratio: CGFloat) -> CGRect {
        return CGRect(x: self.origin.x/ratio, y: self.origin.y/ratio,
                      width: self.width/ratio, height: self.height/ratio)
    }
}

