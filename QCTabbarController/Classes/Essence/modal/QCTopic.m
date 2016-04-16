//
//  QCTopic.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/1.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTopic.h"
#import "NSDate+QC.h"

@implementation QCTopic
{
    CGRect _imageFrame;
    BOOL _bigPicture;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"small_image": @"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2"};
}

/**
 *  处理时间
 *
 *  @return 返回处理好的创建帖子的时间
 */
- (NSString *)passtime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *createTime = [formatter dateFromString:_passtime];
    
    if ([createTime isThisYear]) { // 今年
        if ([createTime isToday]) { // 今天
            NSDateComponents *comp = [[NSDate date] deltaFrom:createTime];
            if (comp.hour >= 1) { // 几小时
                return [NSString stringWithFormat:@"%zd小时前",comp.hour];
            } else if (comp.minute >= 1) { // 几分钟前
                return [NSString stringWithFormat:@"%zd分钟前",comp.minute];
            } else { // 几秒前----> 刚刚
                return [NSString stringWithFormat:@"刚刚"];
            }
        } else if([createTime isYesterday]) { // 昨天
            formatter.dateFormat = @"昨天HH:mm";
            return [formatter stringFromDate:createTime];
        } else {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createTime];
        }
    } else { // 非今年
        return _passtime;
    }
}

/**
 *  根据文字来计算label的高度
 */
- (CGFloat)cellHeight {
    CGSize maxSize = CGSizeMake(cellWidth, MAXFLOAT);
    if (!_cellHeight) {
        CGSize textSize = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        
        if (self.type == QCTopicTypePicture) { // 图片类型
            CGFloat imageHeight = (self.height*cellWidth)/_width;
            
            if (imageHeight > topicCellMaxPictureHeight) {
                self.bigPicture = YES;
                imageHeight = topicCellPictureBreakHeight;
            }
            
            CGFloat imageWidth = cellWidth;
            CGFloat imageX = topicCellMargin;
            CGFloat imageY = textSize.height+ topicCellTextY + topicCellMargin;
            _imageFrame = CGRectMake(imageX, imageY, imageWidth, imageHeight);

            
            
            return textSize.height + topicCellTextY + topicCellBottomHeight + imageHeight + topicCellMargin;
        } else {
            return textSize.height + topicCellTextY + topicCellBottomHeight + topicCellMargin;
        }
    } else {
        return topicCellBottomHeight + topicCellTextY + topicCellMargin;
    }
}
@end
