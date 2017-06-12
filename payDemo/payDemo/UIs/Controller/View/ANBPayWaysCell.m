//
//  ANBPayWaysCell.m
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/24.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "ANBPayWaysCell.h"
#import "Anb_ResourceUtils.h"
#import "ZXPAutoLayout.h"

@interface ANBPayWaysCell ()

@property (nonatomic, strong) UIImageView   *iconImg;
@property (nonatomic, strong) UILabel       *msgLabel;
@property (nonatomic, strong) UIImageView   *selectImg;
@property (nonatomic, strong) UIView        *line;

@property (nonatomic, copy) NSString *iconImgName;
@property (nonatomic, copy) NSString *mainTitle;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *selectImgName;

@end

@implementation ANBPayWaysCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}
// 设置UI布局
- (void)setUp
{
    [self addSubview:self.iconImg];
    [self addSubview:self.msgLabel];
    [self addSubview:self.selectImg];
    [self addSubview:self.line];
    
    __weak typeof(self) weakSelf = self;
    [self.iconImg zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.yCenterByView(weakSelf,0);
        layout.leftSpace(15);
    }];
    [self.msgLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.yCenterByView(weakSelf,0);
        layout.leftSpaceByView(weakSelf.iconImg,10);
    }];
    [self.selectImg zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.yCenterByView(weakSelf,0);
        layout.rightSpaceEqualTo(weakSelf,15);
    }];
    [self.line zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.bottomSpace(0);
        layout.leftSpace(15).rightSpace(15);
        layout.heightValue(1);
    }];
}

// 设置Cell数据
- (void)cellReloadDate:(NSInteger)payWays isSelected:(BOOL)isSelected
{
    switch (payWays) {
        case PayWays_ALIPAY:
        {
            self.iconImgName    = @"icon_alipay_normal";
            self.mainTitle      = @"支付宝";
            self.subTitle       = @"推荐有支付宝客户端的使用";
        }
            break;
        case PayWays_UNION:
        {
            self.iconImgName    = @"icon_upcash_normal";
            self.mainTitle      = @"银联";
        }
            break;
        case PayWays_WECHAT:
        {
            self.iconImgName    = @"icon_wechat_normal";
            self.mainTitle      = @"微信";
            self.subTitle       = @"推荐有微信客户端的使用";
        }
            break;
            
        default:
            break;
    }
    
    if (isSelected) {
        self.selectImgName = @"icon_select_selected";
    } else {
        self.selectImgName = @"icon_select_unselected";
    }
}
#pragma mark - Setter & Getter
- (void)setIconImgName:(NSString *)iconImgName
{
    _iconImgName = iconImgName;
    self.iconImg.image = [[Anb_ResourceUtils manager] image:iconImgName];
}
- (void)setMainTitle:(NSString *)mainTitle
{
    _mainTitle = mainTitle;
    if (_subTitle) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",mainTitle,_subTitle]];
        [attStr addAttributes:@{
                                NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                NSFontAttributeName: [UIFont systemFontOfSize:12],
                                }
                        range:NSMakeRange(mainTitle.length + 1, _subTitle.length)];
        self.msgLabel.attributedText = attStr;
    } else {
        
        self.msgLabel.text = mainTitle;
    }
}
- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",_mainTitle,_subTitle]];
    [attStr addAttributes:@{
                            NSForegroundColorAttributeName: [UIColor lightGrayColor],
                            NSFontAttributeName: [UIFont systemFontOfSize:12],
                            }
                    range:NSMakeRange(_mainTitle.length + 1, subTitle.length)];
    self.msgLabel.attributedText = attStr;
    
}
- (void)setSelectImgName:(NSString *)selectImgName
{
    _selectImgName = selectImgName;
    self.selectImg.image = [[Anb_ResourceUtils manager] image:selectImgName];;
}

#pragma mark - Lazy
- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        _iconImg.backgroundColor = [UIColor clearColor];
        [_iconImg sizeToFit];
    }
    return _iconImg;
}
- (UILabel *)msgLabel
{
    if (!_msgLabel) {
        _msgLabel = [UILabel new];
        _msgLabel.backgroundColor = [UIColor clearColor];
        _msgLabel.numberOfLines = 2;
        [_msgLabel sizeToFit];
    }
    return _msgLabel;
}
- (UIImageView *)selectImg
{
    if (!_selectImg) {
        _selectImg = [UIImageView new];
        _selectImg.backgroundColor = [UIColor clearColor];
        [_selectImg sizeToFit];
    }
    return _selectImg;
}
- (UIView *)line
{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}

@end
