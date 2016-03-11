//
//  QCRecommendUserCell.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/11.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCRecommendUserCell.h"
#import "QCRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface QCRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansContentLabel;



@end

@implementation QCRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(QCRecommendUser *)user {
    _user = user;
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:_user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        NSLog(@"userImageView completed!");
    } ];
    self.screenNameLabel.text = _user.screen_name;
    self.fansContentLabel.text = [NSString stringWithFormat:@"%@人关注", _user.fans_count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)layoutSubviews {
    self.userImageView.layer.cornerRadius = self.userImageView.height * 0.5;
    self.clipsToBounds = YES;
}

@end
