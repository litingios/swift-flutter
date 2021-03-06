//
//  RecommendVC.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/29.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import SwiftMessages
import ESPullToRefresh

class RecommendVC: LTSuperViewController {
    
    private var slidesList: [SlidesModel]? // 穿插的广告数据
    private var booksList: [BookItemModel]? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.page = 1
        self.layout.minimumLineSpacing = 6
        self.layout.minimumInteritemSpacing = 6
        self.view .addSubview(self.collectionView)
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: 180)
        layout.scrollDirection = .vertical
        self.collectionView.register(UINib.init(nibName: "VerticalBookCell", bundle: nil), forCellWithReuseIdentifier: "VerticalBookCell")
        self.collectionView.register(UINib.init(nibName: "AcrossBookCell", bundle: nil), forCellWithReuseIdentifier: "AcrossBookCell")
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "kHeaderViewID")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(0)
        }
        headerRereshing()        
    }
    
    override func headerRereshing() {
        self.page = 1
        self.isClear = false
        loadData()
        loadBookListData()
    }
    
    override func footerRereshing() {
        self.page += 1
        self.isClear = true
        loadBookListData()
    }
    
    /// 获取轮播图数据
    func loadData() -> Void {
        let path = Bundle.main.path(forResource: "home_ recommend", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let json = JSON(jsonData)
            // 轮播图数据
            if let slidesList = JSONDeserializer<SlidesModel>.deserializeModelArrayFrom(json: json["data"]["module"][0]["content"].description) {
                self.slidesList = slidesList as? [SlidesModel]
            }
            
            UIView .performWithoutAnimation {
                self.collectionView .reloadData()
                self.collectionView.es.stopLoadingMore()
                self.collectionView.es.stopPullToRefresh()
            }
        } catch let error as Error? {
            print("读取本地数据出现错误!",error as Any)
        }
    }
    
    /// 获取类表数据
    func loadBookListData() -> Void {
        let path = Bundle.main.path(forResource: "home_ recommend", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let json = JSON(jsonData)
            // 书籍列表
            if let booksList = JSONDeserializer<BookItemModel>.deserializeModelArrayFrom(json: json["data"]["module"][1]["content"].description) {
                
                if booksList.count < self.page*8 {
                    self.collectionView.es.stopLoadingMore()
                    self.collectionView.es.noticeNoMoreData()
                    return
                }
                if self.isClear == true {
                    let arr = NSArray.init(array: booksList as [Any]).subarray(with: NSRange.init(location: (self.page-1)*8, length: 8))
                    self.booksList = self.booksList! + arr as? [BookItemModel]
                }else{

                    let arr = NSArray.init(array: booksList as [Any]).subarray(with: NSRange.init(location: 0, length: 8))
                    self.booksList = arr as? [BookItemModel]
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIView .performWithoutAnimation {
                    self.collectionView .reloadData()
                    self.collectionView.es.stopLoadingMore()
                    self.collectionView.es.stopPullToRefresh()
                }
            }
        } catch let error as Error? {
            print("读取本地数据出现错误!",error as Any)
        }
    }
}

extension RecommendVC: CommonHeaderViewDelegate {
    // 点击头视图
    func headerViewSelect(){
        showMessageView(msg: "未开发,敬请期待。。。")
    }

}

extension RecommendVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.booksList?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let hang: NSInteger = indexPath.row / 4;
        if hang % 2 == 0 {
            let cell:VerticalBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalBookCell", for: indexPath) as? VerticalBookCell
            cell.model = self.booksList![indexPath.row]
            return cell
        } else {
            let cell:AcrossBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AcrossBookCell", for: indexPath) as? AcrossBookCell
            cell.model = self.booksList![indexPath.row]
            return cell
        }
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let hang: NSInteger = indexPath.row / 4;
        if hang % 2 == 0 {
            return CGSize(width: VerticalWidth , height: VerticalHeight)
        } else {
            return CGSize(width: AcrossWidth, height: AcrossHeight);
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushDetaileVC(model: self.booksList![indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "kHeaderViewID", for: indexPath) as UICollectionReusableView
        let headerImg = CommonHeaderView()
        headerImg.type = .defaulttype
        headerImg.titleStr = "大家都在看"
        headerImg.slidesList = self.slidesList
        headerImg.delegate = self
//        headerImg.homeGoodId = {[weak self]
//            (str: String)in
//            let goodsVC = GoodDetailVC()
//            goodsVC.goodsID = str
//            self?.navigationController?.pushViewController(goodsVC, animated: true)
//        }
        
        headerImg.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 180)
        headerImg.backgroundColor = UIColor .white
        headerView.addSubview(headerImg)
        return headerView
    }
        
}
