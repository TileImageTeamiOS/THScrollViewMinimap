//
//  MinimapView.swift
//  ScrollViewMinimap
//
//  Created by Seong ho Hong on 2017. 12. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit
import AVFoundation

open class THMinimapView: UIView {
    public var focusedBorderWidth: CGFloat = 2.0
    public var focusedBorderColor: CGColor = UIColor.yellow.cgColor
    private var focusedBoxView: UIView = UIView()
    private var scrollView: UIScrollView = UIScrollView()
    private var minimapImageView: UIImageView = UIImageView()
    private var scrollImageView: UIImageView = UIImageView()
    private var downSizeRatio: CGFloat = 4.0
    private var image = UIImage()
    private var minimapImage: UIImage?
    convenience init(scrollView: UIScrollView, downSizeRatio: CGFloat, image: UIImage) {
        self.init(frame: CGRect.zero)
        setUp(scrollView: scrollView, downSizeRatio: downSizeRatio, image: image, minimapImage: nil)
    }
    convenience init(scrollView: UIScrollView, downSizeRatio: CGFloat, image: UIImage, minimapImage: UIImage) {
        self.init(frame: CGRect.zero)
        setUp(scrollView: scrollView, downSizeRatio: downSizeRatio, image: image, minimapImage: minimapImage)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func setUp(scrollView: UIScrollView, downSizeRatio: CGFloat, image: UIImage, minimapImage: UIImage?) {
        let width = scrollView.frame.width / downSizeRatio
        let height = scrollView.frame.height / downSizeRatio
        self.frame = CGRect(x: width * (downSizeRatio - 1), y: height * (downSizeRatio-1), width: width, height: height)

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollImageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                     width: scrollView.frame.width,
                                                     height: scrollView.frame.height))
        minimapImageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                     width: self.frame.width,
                                                     height: self.frame.height))

        focusedBoxView = UIView()

        scrollView.addSubview(scrollImageView)
        self.addSubview(minimapImageView)
        self.addSubview(focusedBoxView)

        scrollImageView.image = image
        if let minimapImage = minimapImage {
            minimapImageView.image = minimapImage
            focusedBoxView.frame = AVMakeRect(aspectRatio: minimapImage.size, insideRect: minimapImageView.bounds)
        } else {
            minimapImageView.image = image
            focusedBoxView.frame = AVMakeRect(aspectRatio: image.size, insideRect: minimapImageView.bounds)
        }
        scrollImageView.contentMode = .scaleAspectFit
        minimapImageView.contentMode = .scaleAspectFit
        focusedBoxView.layer.borderWidth = focusedBorderWidth
        focusedBoxView.layer.borderColor = focusedBorderColor
    }
    public func getScrolledImageView() -> UIImageView {
        return scrollImageView
    }
    public func resize(scrollView: UIScrollView) {
        let scrollBox = AVMakeRect(aspectRatio: (scrollImageView.image?.size)!, insideRect: scrollImageView.frame)
        let box = AVMakeRect(aspectRatio: (minimapImageView.image?.size)!, insideRect: minimapImageView.frame)
        let zoomScale = scrollView.zoomScale
        let widthRatio = box.size.width / scrollBox.size.width
        let heightRatio = box.size.height / scrollBox.size.height
        let newX = (scrollView.contentOffset.x * widthRatio) + (box.origin.x / 2)
        let newY = (scrollView.contentOffset.y * heightRatio) + (box.origin.y / 2)
        let newWidth = box.size.width / zoomScale
        let newHeight = box.size.height / zoomScale
        focusedBoxView.frame = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
}
