//
//  AuthorCollectionViewCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/10.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class AuthorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var authorList: [AuthorInfoModle]? {
        didSet{
            guard authorList != nil else {return}
            self.collectionView .reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(UINib.init(nibName: "AuthorItemCell", bundle: nil), forCellWithReuseIdentifier: "AuthorItemCell")
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = backgroundColor
        self.collectionView.dataSource = self
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
    }

}

extension AuthorCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.authorList!.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:AuthorItemCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AuthorItemCell", for: indexPath) as? AuthorItemCell
        cell.backgroundColor = backgroundColor
        cell.model = self.authorList![indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenWidth - 70, height: 165);
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
