//
//  MinimapDataSource.swift
//  ScrollViewMinimap
//
//  Created by Seong ho Hong on 2017. 12. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

public struct MinimapDataSource {
    private var _scrollView: UIScrollView
    private var _image: UIImage
    private var _borderWidth: Int
    private var _borderColor: CGColor
    private var _ratio: Double
    
    init(scrollView: UIScrollView, image: UIImage, borderWidth: Int, borderColor: CGColor, ratio: Double) {
        self._scrollView = scrollView
        self._image = image
        self._borderWidth = borderWidth
        self._borderColor = borderColor
        self._ratio = ratio
    }
    
    public var scrollView: UIScrollView {
        get {return self._scrollView}
    }
    
    public var image: UIImage {
        get {return self._image}
    }
    
    public var borderWidth: Int {
        get {return self._borderWidth}
        set {self._borderWidth = newValue}
    }
    
    public var borderColor: CGColor {
        get {return self._borderColor}
        set {self._borderColor = newValue}
    }
    
    public var ratio: Double {
        get {return self._ratio}
        set {self._ratio = newValue}
    }
    
    public var minimapImageHeight: CGFloat {
        get {return CGFloat(Double(image.size.height)/ratio)}
    }
    
    public var minimapImageWidth: CGFloat {
        get {return CGFloat(Double(image.size.width)/ratio)}
    }
    
    public var scrollViewZoomScale: Double {
        get {return Double(scrollView.zoomScale)}
    }
    
    public var scrollViewX: Double {
        get {return Double(scrollView.contentOffset.x)}
    }
    
    public var scrollViewY: Double {
        get {return Double(scrollView.contentOffset.y)}
    }
    
    public var scrollViewHeight: Double {
        get {return Double(scrollView.bounds.size.height)}
    }
    
    public var scrollViewWidth: Double {
        get {return Double(scrollView.bounds.size.width)}
    }
}
