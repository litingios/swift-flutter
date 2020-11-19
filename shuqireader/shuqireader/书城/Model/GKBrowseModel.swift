//
//  GKBrowseModel.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import HandyJSON

class GKBrowseModel: HandyJSON {
    
    var bookId     :String?       = "";
    var updateTime :TimeInterval  = 0;
    var chapter    :NSInteger?    = 0;
    var pageIndex  :NSInteger?    = 0;
    
    var bookModel  :GKBookModel!;
    var source     :GKNovelSource!;
    var chapterInfo:GKNovelChapterInfo!;
    
    required init() {}
}
