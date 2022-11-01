//
//  ScrollViewViewController.swift
//  TestSimple
//
//  Created by lidongyang on 2022/4/14.
//

import Foundation
import UIKit

public class ScrollViewViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let image = UIImage(named: "image1.jpg")!
    lazy var imageView = UIImageView(image: image)
    
    public override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.frame = view.bounds
        scrollView.contentSize = image.size
        scrollView.delegate = self
        setScrollViewScale()
        setupGestureRecognizer()
    }
    
    public override func viewWillLayoutSubviews() {
        setScrollViewScale()
    }
    
    func setScrollViewScale() {
        let imageSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        scrollView.minimumZoomScale = min(scrollViewSize.width / imageSize.width, scrollViewSize.height / imageSize.height)
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
    }
}

extension ScrollViewViewController {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        let verticalPadding = imageViewSize.height < scrollViewSize.height ?  (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding  =  imageViewSize.width  <  scrollViewSize.width  ?  (scrollViewSize.width - imageViewSize.width) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    func  setupGestureRecognizer()  {
        let  doubleTap  =  UITapGestureRecognizer(target:  self,  action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired  =  2
        scrollView.addGestureRecognizer(doubleTap)

    }

    @objc func handleDoubleTap(recognizer:  UITapGestureRecognizer)  {
        if  (scrollView.zoomScale  >  scrollView.minimumZoomScale)  {
            scrollView.setZoomScale(scrollView.minimumZoomScale,  animated:  true)
        }  else  {
            scrollView.setZoomScale(scrollView.maximumZoomScale,  animated:  true)
        }
    }
}
