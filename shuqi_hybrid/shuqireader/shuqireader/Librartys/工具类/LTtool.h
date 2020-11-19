//
//  LTtool.h
//  shuqireader
//
//  Created by 李霆 on 2020/10/22.
//  Copyright © 2020 mziyuting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTtool : NSObject

#pragma mark 字符串转码
+ (NSString *)stringURLEncode:(NSString *)url;
#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;
#pragma mark 时间戳转换字符串
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval andFormatStr:(NSString *)formatStr;
#pragma mark 颜色转化
+ (UIColor *)colorWithHexString:(NSString *)color;
#pragma mark - 获取当前时间的 时间戳
+(NSString *)getNowTimestamp;
#pragma mark 设置行距
+(void)setLable:(UILabel *)lable withHangJu:(int)HnagJu withString:(NSString*)str;
#pragma mark 设置行距和颜色
+ (void)changeLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable withHnagJu:(int)HnagJu;
#pragma mark 计算字符串宽度
+(CGFloat ) widthForString:(NSString *)value fontSize:(UIFont *)fontSize andHeight:(CGFloat)height;
#pragma mark 计算字符串高度
+(CGFloat) heightForString:(NSString *)value fontSize:(UIFont *)fontSize andWidth:(float)width;
#pragma mark 计算高度
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withHangJu:(int)HangJu;
#pragma mark 设置颜色
+ (void)changeLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable;
#pragma mark 设置分段颜色字号
+ (void)changeSectionLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withTwoStartRange:(NSInteger )twoStartRange withTwoLength:(NSInteger)twoLength withLable:(UILabel *)handleLable;
#pragma mark 设置字号
+ (void)changeLableTextFontWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable;
#pragma mark 计算高度
+ (CGFloat)computeLableHeightWithFont:(UIFont*)font withStr:(NSString *)str withWidth:(CGFloat)Width;
#pragma mark 修改 Placeholder 颜色字体大小
+ (NSMutableAttributedString *)changePlaceholder:(NSString *)holderText andFont:(UIFont *)font andColor:(UIColor *)color;

- (void)textMethond;

@end

NS_ASSUME_NONNULL_END
