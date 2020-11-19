//
//  BookDetailVC.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import SwiftMessages
import ESPullToRefresh

class BookDetailVC: LTSuperViewController {

    private var booksInfoList: [DetailModel]? // 书籍信息
    var model: BookItemModel?{
        didSet{
            guard let model = model else {return}
            self.model = model
        }
    }
    
    lazy var boottowView: UIView = {
        let boottowView = UIView()
        boottowView.backgroundColor = UIColor.white
        return boottowView
    }()
    
    lazy var addBookBtn: UIButton = {
        let addBookBtn = UIButton()
        addBookBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        addBookBtn .setTitle("加书架", for: .normal)
        addBookBtn .setTitleColor(UIColor.black, for: .normal)
        setRounded(view: addBookBtn, 1, UIColor.white, 4)
        addBookBtn .addTarget(self, action: #selector(addBookBtnCiled), for: .touchUpInside)
        return addBookBtn;
    }()
    
    lazy var rederBtn: UIButton = {
        let rederBtn = UIButton()
        rederBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        rederBtn .setTitle("开始阅读", for: .normal)
        rederBtn .setTitleColor(UIColor.white, for: .normal)
        rederBtn.backgroundColor = MainColor
        setRounded(view: rederBtn, 1, MainColor, 4)
        rederBtn .addTarget(self, action: #selector(rederBtnCiled), for: .touchUpInside)
        return rederBtn;
    }()
    
    
    // 加入书架
    @objc func addBookBtnCiled() ->(Void){
    
    }
    // 开始阅读
    @objc func rederBtnCiled() ->(Void){
        
        let path = Bundle.main.path(forResource: "book_article", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let json = JSON(jsonData)
            // 书籍列表
            if let gkbookModel = JSONDeserializer<GKBookModel>.deserializeFrom(json: json.description) {
                let view = RederBookManager(bookModel: gkbookModel,indexPath: 0)
                self.navigationController?.pushViewController(view, animated: true)
            }
        } catch _ as Error? {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        loadData()
        creatUI()
    }
    
    func creatUI() -> Void {
        
        
        self.navBarBackgroundAlpha = 0
        self.view .addSubview(self.collectionView)
        self.collectionView.es.removeRefreshFooter()
        self.collectionView.es.removeRefreshHeader()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.scrollDirection = .vertical
        self.collectionView.register(UINib.init(nibName: "BookDetailCell", bundle: nil), forCellWithReuseIdentifier: "BookDetailCell")
        self.collectionView.register(UINib.init(nibName: "CommitListCell", bundle: nil), forCellWithReuseIdentifier: "CommitListCell")
        self.collectionView.register(UINib.init(nibName: "FenCell", bundle: nil), forCellWithReuseIdentifier: "FenCell")
        self.collectionView.register(UINib.init(nibName: "BookInfoCell", bundle: nil), forCellWithReuseIdentifier: "BookInfoCell")
        self.collectionView.register(UINib.init(nibName: "VerticalBookCell", bundle: nil), forCellWithReuseIdentifier: "VerticalBookCell")
        self.collectionView.register(UINib.init(nibName: "AcrossBookCell", bundle: nil), forCellWithReuseIdentifier: "AcrossBookCell")

        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "kHeaderViewID")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-(SAFEAREA_BOTTOM+60))
        }
        self.collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        self.view .addSubview(self.boottowView)
        self.boottowView .addSubview(self.addBookBtn)
        self.boottowView .addSubview(self.rederBtn)
        self.boottowView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-SAFEAREA_BOTTOM)
            make.height.equalTo(60)
        }
        self.addBookBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo((ScreenWidth-30)/2)
        }
        self.rederBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.addBookBtn.snp.right).offset(10)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo((ScreenWidth-30)/2)
        }
    }
    
    func loadData() -> Void {
        let path = Bundle.main.path(forResource: "detail", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let json = JSON(jsonData)
            // 书籍列表
            if let booksList = JSONDeserializer<DetailModel>.deserializeModelArrayFrom(json: json["data"]["modulesInfos"].description) {
                self.booksInfoList = booksList as? [DetailModel]
            }
            
            UIView .performWithoutAnimation {
                self.collectionView .reloadData()
            }
        } catch let error as Error? {
            print("读取本地数据出现错误!",error as Any)
        }
    }

    
}


extension BookDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.booksInfoList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3 || section == 4 || section == 5{
            return self.booksInfoList![section].books!.count
        }
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell:BookDetailCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailCell", for: indexPath) as? BookDetailCell
            var model = self.booksInfoList![indexPath.section]
            model.imgUrl = self.model?.imgUrl
            model.bookName = self.model?.bookName
            model.authorName = self.model?.authorName
            model.category = self.model?.className
            model.desc = self.model?.desc
            cell.model = model
            cell.delegate = self
            return cell
            
        }else if indexPath.section == 1 {
            let cell:CommitListCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "CommitListCell", for: indexPath) as? CommitListCell
            cell.commitList = self.booksInfoList![indexPath.section].commentList
            return cell
            
        }else if indexPath.section == 2 {
            let cell:FenCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "FenCell", for: indexPath) as? FenCell
            cell.model = self.booksInfoList![indexPath.section]
            return cell
        }else if indexPath.section == 3 || indexPath.section == 5{
            let cell:AcrossBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "AcrossBookCell", for: indexPath) as? AcrossBookCell
            cell.model = self.booksInfoList![indexPath.section].books![indexPath.row]
            return cell
        }else if indexPath.section == 4{
            let cell:VerticalBookCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalBookCell", for: indexPath) as? VerticalBookCell
            cell.model = self.booksInfoList![indexPath.section].books![indexPath.row]
            return cell
        }else{
            let cell:BookInfoCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "BookInfoCell", for: indexPath) as? BookInfoCell
            cell.model = self.booksInfoList![indexPath.section]
            return cell
        }
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 3 || section == 4 || section == 5 {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: self.view.frame.size.width, height: 430);

        }else if indexPath.section == 1 {
            return CGSize(width: self.view.frame.size.width , height: 165);

        }else if indexPath.section == 2 {
            return CGSize(width: self.view.frame.size.width, height: 75);

        }else if indexPath.section == 3 || indexPath.section == 5 {
            return CGSize(width: self.view.frame.size.width-30, height: 130);
        }else if indexPath.section == 4 {
            return CGSize(width: VerticalWidth, height: VerticalHeight)
            
        }else{
            return CGSize(width: self.view.frame.size.width, height: 90);
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "kHeaderViewID", for: indexPath) as UICollectionReusableView
            if headerView.subviews.count > 0{
                headerView.subviews.forEach({$0.removeFromSuperview()})
            }
            if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 6 {
                if indexPath.section == 6 {
                    let lineLab = UILabel()
                    lineLab.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 1)
                    lineLab.backgroundColor = BackViewColor
                    headerView .addSubview(lineLab)
                    
                    let button = UIButton()
                    button.frame = CGRect(x: 0, y: 1, width: ScreenWidth, height: 49)
                    button .setTitle("换一批", for: .normal)
                    button .setTitleColor(UIColor(r: 50, g: 50, b: 50), for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    headerView .addSubview(button)

                    let titleView = DetailHeadrView()
                    titleView.titleLable.text = self.booksInfoList![indexPath.section].moduleName
                    titleView.frame = CGRect(x: 0, y: 50, width: ScreenWidth, height: 60)
                    titleView.backgroundColor = UIColor.white
                    headerView .addSubview(titleView)
                    return headerView
                }
                let titleView = DetailHeadrView()
                titleView.titleLable.text = self.booksInfoList![indexPath.section].moduleName
                titleView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 60)
                titleView.backgroundColor = UIColor.white
                headerView .addSubview(titleView)
                return headerView
                
            }else{
                let view = UIView()
                view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 10)
                view.backgroundColor = BackViewColor
                headerView .addSubview(view)
                return headerView
            }
        }else{
            return UIView() as! UICollectionReusableView
        }
        
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 || section == 3 || section == 4 || section == 5 || section == 6 {
            if section == 6 {
                return CGSize(width: ScreenWidth, height: 110)
            }
            return CGSize(width: ScreenWidth, height: 60)
        }else if section == 0 {
            return CGSize(width: 0, height: 0)
        }else{
            return CGSize(width: ScreenWidth, height: 10)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        if offsetY > (navigationBarHeight*2 - 140){
            self.navBarBackgroundAlpha = (offsetY - (navigationBarHeight*2 - 140))/navigationBarHeight
            self.navigationItem.title = self.model?.bookName
        }
        else{
            self.navBarBackgroundAlpha = 0
            self.navigationItem.title = ""
        }
    }
        
    func changeNavBarAnimateWithIsClear(isClear: Bool) -> (Void) {
        UIView .animate(withDuration: 0.6) {
            if isClear == true {
                self.navBarBackgroundAlpha = 0
                self.navigationItem.title = ""
            }else{
                self.navBarBackgroundAlpha = 1.0
                self.navigationItem.title = self.model?.bookName
            }
        }
    }
    
}

extension BookDetailVC: BookDetailCellDelegate {
    func catalogueMethod() {
        let view = CatalogueVC()
        view.model = self.model
        self.navigationController?.pushViewController(view, animated: true)
    }
    

}
