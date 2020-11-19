//
//  GKBookModel.swift
//  shuqireader
//
//  Created by 李霆 on 2020/10/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import HandyJSON
class GKBookModel:HandyJSON {
    
    var bookId    :String?       = "";
    var updateTime:TimeInterval  = 0;
    var author    :String? = "";
    var cover     :String? = "";
    var shortIntro:String? = ""
    var title     :String? = "";
    var majorCate :String? = "";
    var minorCate :String? = "";
    var lastChapter:String? = "";
    
    var retentionRatio :Float! = 0.0;
    var latelyFollower :Int? = 0;
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.bookId     <-- ["bookId","_id"]
        mapper <<<
            self.shortIntro <-- ["shortIntro","longIntro"]
    }
  
}
