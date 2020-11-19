//
//  HomeModel.swift
//  shuqireader
//
//  Created by 李霆 on 2020/9/29.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import HandyJSON

// 轮播图数据 model
struct SlidesModel: HandyJSON {
    var moduleId:Int = 0
    var name: String?
    var imgUrl: String?
}

// 分类数据
struct ClassifyModel: HandyJSON {
    var icon: String?
    var title: String?
    var link: LinkModel?
}

// link
struct LinkModel: HandyJSON {
    var linkType: String?
    var title: String?
    var url: String?
}

// BigModel
struct BigModel: HandyJSON {
    var id: String?
    var m_s_name: String?
    var m_s_class: String?
    var m_s_style: Int = 0
    var content: [BookItemModel]?
    var girlContent: [BookItemModel]?
    var boyContent: [BookItemModel]?
    var authorInfo: [AuthorInfoModle]? // 作者信息
}

// 作者model
struct AuthorInfoModle: HandyJSON {
    var auhtorLevelSecond: String?
    var authorName: String?
    var authorLevel: String?
    var authorDesc: String?
    var authorIcon: String?
    var authorId: String?
    var bookList: [BookItemModel]? // 书籍信息
}

// 书籍 model
struct BookItemModel: HandyJSON {
    var discountNum:Int = 0
    var orgMoney: String?
    var wordCount: String?
    
    var className: String?
    var displayBookName: String?
    var authorId: String?  /// 作者id
    var bookName: String? ///书名
    var bookId: String? /// 书id
    var imgUrl: String?
    var displayAuthorName: String? /// 作者名字
    var classId: String? /// 类型id

    var chargeMode: String? /// 类型id
    var quickPrice: Int = 0 /// 类型id
    var authorName: String? /// 作者名字
    var state: String? /// 状态
    var tag: [String]? /// 标签
    var desc: String? /// 描述
    
    var startTime: String? // 开始时间
    var endTime: String? // 结束时间
    var numClick: String? // 在读人数
    
    var title: String?
    var content: String?
    
}

// 目录 model
struct CatalogueModle: HandyJSON {
    var chapterId: String?
    var title: String?
}

