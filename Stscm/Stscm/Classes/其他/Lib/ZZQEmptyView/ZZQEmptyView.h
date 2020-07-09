//
//  ZZQEmptyView.h
//  ZZQEmptyViewDemo
//
//  Created by 郑志强 on 2018/3/5.
//  Copyright © 2018年 郑志强. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZZQEmptyView;

@protocol ZZQEmptyViewDelegate <NSObject>

@optional

- (void)emptyViewHadClick:(ZZQEmptyView *)emptyView;

@end

typedef NS_ENUM(NSInteger, ZZQEmptyViewMode) {

    ZZQEmptyViewModeNoData,
    ZZQEmptyViewModeNONet,
    
    ZZQEmptyViewModeNoButton,
    ZZQEmptyViewModeNoImage,
    ZZQEmptyViewModeTextOnly,
    ZZQEmptyViewModeWorkOnly
};


typedef void(^REAction)(void);

@interface ZZQEmptyView : UIView

// 图片
@property (strong, nonatomic, readonly) UIImageView *imgView;

// 标题
@property (nonatomic, strong, readonly) UILabel *label;

// 详细说明
@property (nonatomic, strong, readonly) UILabel *detailsLabel;

// 加载按钮
@property (nonatomic, strong, readonly) UIButton *button;

// 点击自动消失，默认为 YES
@property (nonatomic, assign) BOOL autoHide;

// 默认为 ZZQEmptyViewModeNoDate
@property (nonatomic, assign) ZZQEmptyViewMode emptyMode;

@property (nonatomic, weak) id<ZZQEmptyViewDelegate> delegate;

//判断是显示流程审核样式，还是其他样式
@property (nonatomic,strong)NSString * showtype;
//判断是显示其他样式的文字地方，还是想工作日志文字现在样式
@property (nonatomic,strong)NSString * workType;

@property (nonatomic,copy)REAction reAction;


+ (instancetype)showEmptyViewAddTo:(UIView *)view withEmptyMode:(ZZQEmptyViewMode)emptyMode;

+ (BOOL)hideEmptyViewForView:(UIView *)view;

+ (ZZQEmptyView *)emptyView:(UIView *)view;


- (instancetype)initWithView:(UIView *)view;

- (void)hide;

@end
