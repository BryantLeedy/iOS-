//
//  MessageViewController.swift
//  TestSimple
//
//  Created by lidongyang on 2022/4/11.
//

import Foundation
import UIKit

class MessageViewController: UIViewController {


    private let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let layout = UICollectionViewFlowLayout()

    private let imageCell = "imageCell"
    private let imageHeader = "imageHeader"
    private let imageFooter = "imageFooter"

    override func viewDidLoad() {
        super.viewDidLoad()

        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);

        // 設置每一行的間距
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3

        // 設置每個 cell 的尺寸
//        layout.itemSize = CGSize(width: CGFloat(screenSize.width)/3 - 5.0, height: CGFloat(screenSize.width)/3 - 5.0)

        // 設置 header 及 footer 的尺寸
        layout.headerReferenceSize = CGSize(
          width: screenSize.width, height: 40)
        layout.footerReferenceSize = CGSize(
          width: screenSize.width, height: 40)
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: imageCell)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: imageHeader)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: imageFooter)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self

        setupViews()
    }

    func setupViews() {

    }
}


extension MessageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
        collectionView.dequeueReusableCell(
            withReuseIdentifier: imageCell, for: indexPath)
          as! CollectionViewCell

            // 設置 cell 內容 (即自定義元件裡 增加的圖片與文字元件)
        let image = UIImage(named: "image\(indexPath.row).jpg")!
        cell.imageView.image = image
        let imageSize = CGSize(width: image.size.width / 10, height: image.size.height / 10)
        layout.itemSize = imageSize
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: imageHeader, for: indexPath) as! CollectionHeaderView

            header.label.text = "相册上面"
            return header
        }
        else if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: imageFooter, for: indexPath) as! CollectionHeaderView

            footer.label.text = "相册下面"
            return footer
        }
        return UICollectionReusableView()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}

extension MessageViewController: UICollectionViewDelegate {

}
