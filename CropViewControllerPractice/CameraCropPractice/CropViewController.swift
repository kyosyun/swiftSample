//
//  CropViewController.swift
//  CameraCropPractice
//
//  Created by Keisei Saito on 2017/10/11.
//  Copyright © 2017 Keisei Saito. All rights reserved.
//

import UIKit

protocol CropViewControllerDelegate: class {
    func cropViewControllerDidFinishTask(_ image: UIImage)
}

class CropViewController: UIViewController, UIScrollViewDelegate {
    private var scrollView: UIScrollView!
    private var imageView: UIImageView!
    private var image: UIImage!
    weak var delegate: CropViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ImageViewを準備
        imageView = UIImageView(image: image)

        // ScrollViewを準備
        scrollView = CropScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        scrollView.center = view.center
        scrollView.delegate = self

        // ImageViewとScrollViewをビューに追加
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)

        // 最初は写真全体を表示
        setZoomScale()

        // 切り取り領域ビューの準備
        view.addSubview(CropOverlayView())

        // 決定ボタンを準備
        let confirmButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        confirmButton.setTitle("決定", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: confirmButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        NSLayoutConstraint(item: confirmButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 66).isActive = true
        NSLayoutConstraint(item: confirmButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: confirmButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8).isActive = true

        // キャンセルボタンを準備
        let cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        cancelButton.setTitle("キャンセル", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        NSLayoutConstraint(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 66).isActive = true
        NSLayoutConstraint(item: cancelButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: cancelButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -8).isActive = true
    }

    func prepareView(image: UIImage) {
        self.image = image
    }

    func didTapConfirmButton() {
        // クロップ
        let width = scrollView.bounds.width
        let height = width
        let x = scrollView.bounds.origin.x
        let y = scrollView.bounds.origin.y
        let cropBounds = CGRect(x: x, y: y, width: width, height: height)
        let visibleRect = imageView.convert(cropBounds, from: scrollView)

        // 画像生成
        UIGraphicsBeginImageContext(visibleRect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.black.cgColor)
        let backRect = CGRect(x: 0, y: 0, width: visibleRect.width, height: visibleRect.height)
        context?.fill(backRect)
        let drawRect = CGRect(x: -visibleRect.origin.x, y: -visibleRect.origin.y, width: image!.size.width, height: image!.size.height)
        image!.draw(in: drawRect)
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // 呼び出し元に渡す
        delegate?.cropViewControllerDidFinishTask(croppedImage)
        dismiss(animated: true)
    }

    func dismissSelf() {
        dismiss(animated: true)
    }

    private func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = min(widthScale, heightScale)
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size

        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
