//
//  BoyVC.swift
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

class BoyVC: LTSuperViewController {

    private var slidesList: [SlidesModel]? // 穿插的广告数据
    private var classifyList: [ClassifyModel]? // 分类数据
    private var booksList: [BigModel]? // 书籍信息
    let headerImg = CommonHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.page = 1
        self.view .addSubview(self.collectionView)
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
        let path = Bundle.main.path(forResource: "home_boy", ofType: "json")
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
            // 分类数据
            if let classifyList = JSONDeserializer<ClassifyModel>.deserializeModelArrayFrom(json: json["data"]["module"][0]["classify"].description) {
                self.classifyList = classifyList as? [ClassifyModel]
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
        if self.isClear == true {
            self.collectionView.es.stopLoadingMore()
            self.collectionView.es.noticeNoMoreData()
            return
        }
        
        let path = Bundle.main.path(forResource: "home_boy", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let json = JSON(jsonData)
            // 书籍列表
            if let booksList = JSONDeserializer<BigModel>.deserializeModelArrayFrom(json: json["data"]["module"].description) {
                self.booksList = booksList as? [BigModel]
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
}

extension BoyVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.booksList!.count - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.booksList?[section+1].content!.count)!
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell:AcrossBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AcrossBookCell", for: indexPath) as? AcrossBookCell
                cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
                return cell
            }else{
                let cell:VerticalBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalBookCell", for: indexPath) as? VerticalBookCell
                cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
                return cell
            }
        }else if indexPath.section == 1 {
            let cell:AcrossBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AcrossBookCell", for: indexPath) as? AcrossBookCell
            cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
            return cell
            
        }else if indexPath.section == 2 {
            let cell:VerticalBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalBookCell", for: indexPath) as? VerticalBookCell
            cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
            return cell
            
        }else if indexPath.section == 3 {
            let cell:AcrossBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AcrossBookCell", for: indexPath) as? AcrossBookCell
            cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
            return cell
            
        }else if indexPath.section == 4 {
            let cell:AcrossBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AcrossBookCell", for: indexPath) as? AcrossBookCell
            cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
            return cell
            
        }else{
            let hang: NSInteger = indexPath.row / 4;
            if hang % 2 == 0 {
                let cell:VerticalBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalBookCell", for: indexPath) as? VerticalBookCell
                cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
                return cell
            } else {
                let cell:AcrossBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AcrossBookCell", for: indexPath) as? AcrossBookCell
                cell.model = self.booksList![indexPath.section+1].content![indexPath.row]
                return cell
            }
        }
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return CGSize(width: AcrossWidth, height: AcrossHeight)

            }else{
                return CGSize(width: VerticalWidth , height: VerticalHeight)

            }
        }else if indexPath.section == 1 {
            return CGSize(width: AcrossWidth, height: AcrossHeight)

            
        }else if indexPath.section == 2 {
            return CGSize(width: VerticalWidth , height: VerticalHeight)

            
        }else if indexPath.section == 3 {
            return CGSize(width: AcrossWidth, height: AcrossHeight)

        }else if indexPath.section == 4 {
            return CGSize(width: AcrossWidth, height: AcrossHeight)

            
        }else{
            let hang: NSInteger = indexPath.row / 4;
            if hang % 2 == 0 {
                return CGSize(width: VerticalWidth , height: VerticalHeight)
            } else {
                return CGSize(width: AcrossWidth, height: AcrossHeight)
            }
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushDetaileVC(model: self.booksList![indexPath.section+1].content![indexPath.row])

    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "kHeaderViewID", for: indexPath) as UICollectionReusableView
            if headerView.subviews.count > 0{
                headerView.subviews.forEach({$0.removeFromSuperview()})
            }
            if indexPath.section == 0 {
                let headerImg = CommonHeaderView()
                headerImg.type = .boytype
                headerImg.slidesList = self.slidesList
                headerImg.classifyList = self.classifyList
                headerImg.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 220)
                headerImg.backgroundColor = UIColor .white
                headerView.addSubview(headerImg)

                let titleView = TitleView()
                titleView.type = .defaulttype
                titleView.titleLable.text = self.booksList![indexPath.section+1].m_s_name
                titleView.frame = CGRect(x: 0, y: 220, width: ScreenWidth, height: 60)
                titleView.backgroundColor = UIColor.white
                headerView .addSubview(titleView)
                return headerView
            }else{
                let titleView = TitleView()
                titleView.titleLable.text = self.booksList![indexPath.section+1].m_s_name
                titleView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 60)
                titleView.backgroundColor = UIColor.white
                headerView.addSubview(titleView)
                return headerView
            }
        }else{
            return UIView() as! UICollectionReusableView
        }
        
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: ScreenWidth, height: 280)
        }else{
            return CGSize(width: ScreenWidth, height: 70)
        }
    }
    
}
