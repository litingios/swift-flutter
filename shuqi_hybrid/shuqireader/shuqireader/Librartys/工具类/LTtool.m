//
//  LTtool.m
//  shuqireader
//
//  Created by 李霆 on 2020/10/22.
//  Copyright © 2020 mziyuting. All rights reserved.
//

#import "LTtool.h"

@implementation LTtool

+ (NSString *)stringURLEncode:(NSString *)url {
    if ([url respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
            - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
            - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
            - parameter string: The string to be percent-escaped.
            - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@?/"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < url.length) {
            NSUInteger length = MIN(url.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [url rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [url substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)url,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma mark 时间戳转换字符串
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval andFormatStr:(NSString *)formatStr{
    NSTimeInterval seconds = [timeInterval integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.dateFormat = formatStr;
    return [format stringFromDate:date];
}

#pragma mark - 转换RGB颜色
+ (UIColor *)colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark - 获取当前时间的 时间戳
+(NSString *)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
}

#pragma mark --------- 计算富文本的lable高度
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withHangJu:(int)HangJu{
    if (str.length == 0) {
        return 0;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing = HangJu;  // 段落高度

    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:str];

    [attributes addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    [attributes addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];

    CGSize attSize = [attributes boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return attSize.height;
}

+(CGFloat )widthForString:(NSString *)value fontSize:(UIFont *)fontSize andHeight:(CGFloat)height{
    // 设置文字属性 要和label的一致
    NSDictionary *attributes = @{NSFontAttributeName : fontSize};     //字体属性，设置字体的font
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);     //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    CGSize size = [value boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(size.width);     //此方法结合  预编译字符串  字体font  字符串宽高  三个参数计算文本  返回字符串宽度
}


+(CGFloat) heightForString:(NSString *)value fontSize:(UIFont *)fontSize andWidth:(float)width{
    
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :fontSize};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 计算文字占据的宽高
    CGSize size = [value boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}

#pragma mark --------- lable添加间距
+(void)setLable:(UILabel *)lable withHangJu:(int)HnagJu withString:(NSString*)str {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (str.length == 0) {
        return;
    }
    // 行间距设置为30
    [paragraphStyle  setLineSpacing:HnagJu];
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:str];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    // 设置Label要显示的text
    [lable setAttributedText:setString];
}

#pragma mark --------- lable设置不同的颜色和间距
+ (void)changeLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable withHnagJu:(int)HnagJu{
    if (titleStr.length == 0) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:HnagJu];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:textColor
                          range:NSMakeRange(startRange, length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:textFont
                          range:NSMakeRange(startRange, length)];
    [AttributedStr  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [titleStr length])];
    
    handleLable.attributedText = AttributedStr;
}


#pragma mark --------- lable设置不同的颜色
+ (void)changeLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable{
    if (titleStr.length == 0) {
        return;
    }

    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:textColor
                          range:NSMakeRange(startRange, length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:textFont
                          range:NSMakeRange(startRange, length)];
    handleLable.attributedText = AttributedStr;
}

+ (void)changeSectionLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withTwoStartRange:(NSInteger )twoStartRange withTwoLength:(NSInteger)twoLength withLable:(UILabel *)handleLable{
    if (titleStr.length == 0) {
        return;
    }

    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:textColor
                          range:NSMakeRange(startRange, length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:textFont
                          range:NSMakeRange(startRange, length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:textColor
                          range:NSMakeRange(twoStartRange, twoLength)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:textFont
                          range:NSMakeRange(twoStartRange, twoLength)];
    handleLable.attributedText = AttributedStr;
}


#pragma mark --------- lable设置不同的字号
+ (void)changeLableTextFontWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable{
    if (titleStr.length == 0) {
        return;
    }
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [AttributedStr addAttribute:NSFontAttributeName
                              value:textFont
                              range:NSMakeRange(startRange, length)];
    handleLable.attributedText = AttributedStr;
}

+ (CGFloat)computeLableHeightWithFont:(UIFont*)font withStr:(NSString *)str withWidth:(CGFloat)Width{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGFloat length = [str boundingRectWithSize:CGSizeMake(Width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return length;
}

+ (NSMutableAttributedString *)changePlaceholder:(NSString *)holderText andFont:(UIFont *)font andColor:(UIColor *)color{
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                       value:font
                       range:NSMakeRange(0, holderText.length)];
    return placeholder;
}

- (void)textMethond{
    NSLog(@"测试策划四号地角度看江苏科技肯定是");
}

@end
