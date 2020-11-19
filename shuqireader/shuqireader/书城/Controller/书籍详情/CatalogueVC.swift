//
//  CatalogueVC.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/20.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CatalogueVC: LTSuperViewController {
    
    var model: BookItemModel?{
        didSet{
            guard let model = model else {return}
            self.model = model
        }
    }
    
    private var catalogList: [CatalogueModle]?

    lazy var headerView: UILabel = {
        let headerView = UILabel()
        headerView.textColor = BlackTextColor
        headerView.font = UIFont.systemFont(ofSize: 15)
        return headerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.model?.bookName
        
        self.view.backgroundColor = BackViewColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "CatalogueCell", bundle: nil), forCellReuseIdentifier: "CatalogueCell")
        self.tableView.rowHeight = 50
        self.tableView.es.removeRefreshFooter()
        self.tableView.es.removeRefreshHeader()
        
        self.view .addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        self.view .addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(0)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-SAFEAREA_BOTTOM)
        }
        loadData()
    }
    
    
    func loadData() -> Void {
        let path = Bundle.main.path(forResource: "bookCatalog", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let json = JSON(jsonData)
            // 书籍列表
            if let booksList = JSONDeserializer<CatalogueModle>.deserializeModelArrayFrom(json: json["chapterInfo"]["chapters"].description) {
                self.catalogList = booksList as? [CatalogueModle]
                self.headerView.text = "    连载 共 \(self.catalogList!.count) 章"
            }
            
            UIView .performWithoutAnimation {
                self.tableView .reloadData()
            }
        } catch let error as Error? {
            print("读取本地数据出现错误!",error as Any)
        }
    }

}

extension CatalogueVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.catalogList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CatalogueCell! = tableView.dequeueReusableCell(withIdentifier: "CatalogueCell", for: indexPath) as? CatalogueCell
        cell.model = self.catalogList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = Bundle.main.path(forResource: "book_article", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let json = JSON(jsonData)
            // 书籍列表
            if let gkbookModel = JSONDeserializer<GKBookModel>.deserializeFrom(json: json.description) {
                let view = RederBookManager(bookModel: gkbookModel,indexPath: indexPath.row)
                self.navigationController?.pushViewController(view, animated: true)
            }
        } catch _ as Error? {
        }
    }
    
    
}
