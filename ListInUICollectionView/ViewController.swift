//
//  ViewController.swift
//  ListInUICollectionView
//
//  Created by 滝浪翔太 on 2020/08/18.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//


// 配列の最初のテキストをセクションヘッダーのタイトルにする
import UIKit

enum Section {
    case alphabet
    case number
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var alphabetArray = ["アルファベット" ,"A", "B", "C"]
    var numberArray = ["数字", "1", "2"]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .firstItemInSection
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        layoutConfig.headerMode = .supplementary
//        layoutConfig.footerMode = .supplementary
//        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView.collectionViewLayout = layout
        
        self.dataSource = tableDataSource(collectionView: self.collectionView)
        collectionView.dataSource = self.dataSource
        reloadList()
    }

    func reloadList(){
    var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
    snapshot.appendSections([Section.alphabet, Section.number])
    snapshot.appendItems(self.alphabetArray, toSection: .alphabet)
    snapshot.appendItems(self.numberArray, toSection: .number)
    self.dataSource.apply(snapshot)
    self.collectionView.reloadData()
    }

}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

class tableDataSource: UICollectionViewDiffableDataSource<Section, String> {

    init(collectionView: UICollectionView) {
        let cell = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item
            // content.image, content.secondaryTextでも可能
            cell.contentConfiguration = content
        }
        super.init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: item)
        })
    }
}

