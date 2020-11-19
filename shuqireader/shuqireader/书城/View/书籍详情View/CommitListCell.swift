//
//  CommitListCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class CommitListCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var allBnt: UIButton!
    var commitList: [CommentModel]? {
        didSet{
            guard commitList != nil else {return}
            self.collectionView .reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        allBnt .setTitleColor(UIColor(r: 50, g: 50, b: 50), for: .normal)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "CommitItemCell", bundle: nil), forCellWithReuseIdentifier: "CommitItemCell")
    }
    
    @IBAction func allBtnCiled(_ sender: Any) {
    }
}

extension CommitListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.commitList?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CommitItemCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "CommitItemCell", for: indexPath) as? CommitItemCell
        cell.backgroundColor = UIColor.init(r: 241, g: 240, b: 246)
        cell.contentMode = UIView.ContentMode.scaleToFill
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.cornerRadius = 6
        cell.layer.masksToBounds = true
        cell.model = self.commitList![indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ScreenWidth - 40, height: 115);

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
