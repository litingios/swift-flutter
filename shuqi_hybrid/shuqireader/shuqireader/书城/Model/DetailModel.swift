//
//  DetailModel.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import HandyJSON

// 书籍详情 model
struct DetailModel: HandyJSON {
    var recIntro: String? // 推荐原因
    var desc: String? // 图书描述
    var imgUrl: String? // 图片
    var displayState: String? // 图书状态，完结
    var category: String? // 分类 ，古代言情
    var authorName: String? // 作者名字
    var bookName: String? // 书名
    var score: String? // 星级数
    var oldScore: String? // 原来的星数
    var people: String? // 人评分
    var readingNum: String? // 已读数
    var popularity: String? // 人气值
    var ziNum: String? // 字数
    var chapterTitle: String? // 状态
    var chapterState: String? 
    var buttonText: String? // 底部按钮
    var defaultButtonText: String? //
    var shelfStatus: String? //
    var moduleName: String? // 头视图文字
    var size: String? // 评论数
    var commentList: [CommentModel]? // 评论列表
    var list: [FenModel]? //粉丝列表
    var books: [BookItemModel]? // 书籍
    var recommendTicketNum: String? // 投票数
    var rewardNum: String? // 打赏数
    
    var copyRightSource: String? //
    var copyRightClaim: String?
}

// 评论 model
struct CommentModel: HandyJSON {
    var userPhoto: String? // 评论者头像
    var pubTime: Double = 0 // 时间
    var mid: String? // id
    var btype: String? //
    var score: String? // 星级数目
    var uid: String? // uid
    var replyNum: String? // 评论数
    var statusOrigin: String? //
    
    var text: String? // 文字
    var nickName: String? // 名字
    var zanNum: String? // 赞数目
}

// 粉丝 model
struct FenModel: HandyJSON {
    var nickName: String? // 名字
    var fansValue: String? //
    var userId: String? //
    var headPic: String? // 头像
    var bookBean: String? //

}

