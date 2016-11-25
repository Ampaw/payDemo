//
//  ANBPayTitleView.h
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/22.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ANBPayTitleViewDelegate <NSObject>
@optional
- (void)close;
@end

@interface ANBPayTitleView : UIView
@property (nonatomic, weak) id<ANBPayTitleViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<ANBPayTitleViewDelegate>)delegate;
@end
