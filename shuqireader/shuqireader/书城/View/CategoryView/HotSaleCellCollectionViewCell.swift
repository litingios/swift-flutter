//
//  HotSaleCellCollectionViewCell.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class HotSaleCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boyBtn: UIButton!
    @IBOutlet weak var girlBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var theMoreBtn: UIButton!
    @IBOutlet weak var lineLable: UILabel!
    
    var boyList: [BookItemModel]? {
        didSet{
            guard boyList != nil else {return}
            self.collectionView .reloadData()
        }
    }
    
    var girlList: [BookItemModel]? {
        didSet{
            guard girlList != nil else {return}
            self.collectionView .reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "BangCell", bundle: nil), forCellWithReuseIdentifier: "BangCell")

        self.boyBtn .setTitle("男生人气榜", for: .normal)
        self.girlBtn .setTitle("女生人气榜", for: .normal)
        
        self.boyBtn .setTitle("男生人气榜", for: .selected)
        self.girlBtn .setTitle("女生人气榜", for: .selected)
        
        self.boyBtn.isSelected = true
        self.lineLable.backgroundColor = BackViewColor
        
    }

    @IBAction func boyBtnCiled(_ sender: Any) {
        self.boyBtn.isSelected = true
        self.girlBtn.isSelected = false
        self.collectionView .reloadData()
    }
    
    @IBAction func girlBtnCiled(_ sender: Any) {
        self.boyBtn.isSelected = false
        self.girlBtn.isSelected = true
        self.collectionView .reloadData()
    }
    
    @IBAction func moreBtnCiled(_ sender: Any) {
        
    }
}

extension HotSaleCellCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if boyBtn.isSelected == true {
            return self.boyList?.count ?? 0
        }
        return self.girlList?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:BangCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "BangCell", for: indexPath) as? BangCell
        cell.backgroundColor = UIColor.white
        if boyBtn.isSelected == true {
            cell.model = self.boyList?[indexPath.row]
        }else{
            cell.model = self.girlList?[indexPath.row]
        }
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (ScreenWidth - 70)/2, height: 70);

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
