//
//  GKNovelChapter.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import HandyJSON
class GKNovelChapter: HandyJSON {
    var bookId:String = "";
    var chapterId:String = "";
    var chapterCover:String = "";
    var link:String = "";
    var time:String = "";
    var title:String = "";
    
    var isVip:Bool = false;
    
    var order:Int = 0;
    var chapterIndex:Int = 0;
    var partsize:Int = 0;
    var totalpage:Int = 0;
    var currency:Int = 0;
    
    required init() {}
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.chapterId <-- ["chapterId","id"]
    }
    var content : GKNovelContent?{
        get{
            let json = GKCache.values(key: self.chapterId)
            if let info = GKNovelContent.deserialize(from: json.rawString()){
                return info
            }
            return GKNovelContent()
        }
    }
}

class GKNovelChapterInfo: HandyJSON {
    var _id:String = "";
    var source:String = "";
    var updated:String = "";
    var book:String = "";
    var starting:String = "";
    var link:String = "";
    var host:String = "";
    var name:String = "";
    
    var chapters:[GKNovelChapter] = [];
    
    required init() {}
}
