//
//  ViewController.swift
//  ScrollViewMinimap
//
//  Created by Seong ho Hong on 2017. 12. 30..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var minimapView: THMinimapView!
    
    var minimapDataSource: THMinimapDataSource!


    override func viewDidLoad() {
        super.viewDidLoad()

        minimap()

        scrollView.contentInsetAdjustmentBehavior = .never
        imageView.frame.size = (imageView.image?.size)!
        scrollView.delegate = self
        
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }

    func minimap() {
        let thumbnailImageURL = Bundle.main.url(forResource: "smallBench", withExtension: "jpg")!
        
        minimapDataSource = MyMinimapDataSource(scrollView: scrollView, thumbnailImage: UIImage(contentsOfFile: thumbnailImageURL.path)!, originImageSize: CGSize(width: 5214, height: 7300))
        minimapDataSource.borderWidth = 2.0
        minimapDataSource.borderColor = UIColor.yellow
        minimapDataSource.downSizeRatio = 4.0

        minimapView.set(dataSource: minimapDataSource)
    }

    
    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
    
    func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        
        let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
    func setZoomParametersForSize(_ scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = minScale
    }

}

extension ViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        minimapDataSource.resizeMinimapView(minimapView: minimapView)
    }
}

