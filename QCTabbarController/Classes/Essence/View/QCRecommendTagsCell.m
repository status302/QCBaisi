//
//  QCRecommendTagsCell.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/12.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCRecommendTagsCell.h"
#import "QCRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface QCRecommendTagsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation QCRecommendTagsCell

-(void)setRecommendTag:(QCRecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    self.themeNameLabel.text = recommendTag.theme_name;
    if (recommendTag.sub_number > 10000) { //保留一位小数格式化 ------> %.1f
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number/10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = 5.0;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
