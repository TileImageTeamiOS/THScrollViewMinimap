# UIScrollView_minimap

[![Version](https://img.shields.io/badge/pod-0.1.0-blue.svg)](http://cocoapods.org/pods)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://github.com/younatics/YNDropDownMenu/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/younatics/YNDropDownMenu.svg?branch=master)](https://travis-ci.org/younatics/YNDropDownMenu)
[![Platform](https://img.shields.io/cocoapods/p/YNDropDownMenu.svg?style=flat)](http://cocoapods.org/pods)
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-%23FB613C.svg)](https://developer.apple.com/swift/)


## Demo

![minimap_demo](images/minimap_demo.gif)


## Usage

```Swift
// StoryBoard에 MinimapView 위치 설정
@IBOutlet weak var minimapView: MinimapView!

// minimap이 참고할 scrollView 와 imageView 설정
minimapDataSource = MyMinimapDataSource(scrollView: scrollView, thumbnailImage: imageView.image!)

// mimimap의  borderWidth 설정
minimapDataSource.borderWidth = 2.0

// minimap의 color 설정
minimapDataSource.borderColor = UIColor.yellow

// minimap이 참고한 image 사이즈의 비율 정하기 (ex, image의 1/70 크기)
minimapDataSource.downSizeRatio = 70.0

// minimapView에 설정
minimapView.set(dataSource: minimapDataSource)
```


## MinimapView and Data Source

MinimapView는 ScrollView와 그 안의 ImageView를 참조하여 Minimap을 그립니다. DataSource안에서는 Minimap 안의 현재 보이는 곳의 view를 그리는 속성등을 설정할수 있습니다.


## Installation

UIScrollView_minimap은 cocoapods으로 설정할수 있습니다. PodFile에 다음과 같은 코드를 넣어주세요.

```
pod "UIScrollView_minimap"
```
