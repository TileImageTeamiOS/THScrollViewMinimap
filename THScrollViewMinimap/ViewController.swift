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
    var minimapView: THMinimapView?
    // images
    let minimapImage = UIImage(named: "smallBench.jpg")!
    let image = UIImage(named: "bench.jpg")!
    func setZoomParameters() {
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setZoomParameters()
        // minimap
        minimapView = THMinimapView(scrollView: scrollView, downSizeRatio: 4, image: image, minimapImage: minimapImage)
        self.view.addSubview(minimapView!)
    }
}
extension ViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return minimapView?.getScrolledImageView()
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        minimapView?.resize(scrollView: scrollView)
    }
}
