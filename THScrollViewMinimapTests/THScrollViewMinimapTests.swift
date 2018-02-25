//
//  THScrollViewMinimapTests.swift
//  THScrollViewMinimapTests
//
//  Created by Seong ho Hong on 2018. 2. 23..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import XCTest
@testable import THScrollViewMinimap

class THScrollViewMinimapTests: XCTestCase {

    var scrollView = UIScrollView()
    var imageView = UIImageView()
    var view = UIView()
    var minimapView: THMinimapView!
    var minimapDataSource: THMinimapDataSource!

    let thumbnailImageURL = Bundle.main.url(forResource: "smallBench", withExtension: "jpg")!

    override func setUp() {
        super.setUp()

        // ViewController set
        imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 4000, height: 5000))
        scrollView.addSubview(imageView)
        view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 500))
        view.addSubview(scrollView)
        scrollView.delegate = self
        recenterImage()

        // minimap set
        minimapView = THMinimapView()
        view.addSubview(minimapView)
        minimapView.frame = CGRect(x: 300, y: 300, width: 25, height: 25)
        minimapDataSource = MyMinimapDataSource(scrollView: scrollView,
                                                thumbnailImage: UIImage(contentsOfFile: thumbnailImageURL.path)!,
                                                originImageSize: CGSize(width: 5214, height: 7300))
        minimapDataSource.borderWidth = 2.0
        minimapDataSource.borderColor = UIColor.yellow
        minimapDataSource.downSizeRatio = 4.0

        minimapView.set(dataSource: minimapDataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMinimap() {
        // set minimap test
        XCTAssertEqual(minimapView.focusedBoxView?.frame,
                       minimapView.minimapImageView?.frame)
    }
}

extension THScrollViewMinimapTests: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        minimapDataSource.resizeMinimapView(minimapView: minimapView)
    }

    func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size

        let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace,
                                               bottom: verticalSpace, right: horizontalSpace)
    }
}
