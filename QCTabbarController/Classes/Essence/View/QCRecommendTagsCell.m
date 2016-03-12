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
    self.themeNameLabel.text = recommendTag.theme_name;
    self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
