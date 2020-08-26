//
//  RSAddRoleCell.h
//  Stscm
//
//  Created by mac on 2020/7/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RSCustomTextView.h"
@class RSAddRoleCell;
NS_ASSUME_NONNULL_BEGIN

@protocol RSAddRoleCellDelegate <NSObject>

- (void)textViewCell:(RSAddRoleCell *)cell didChangeText:(UITextView *)textView;


@end


@interface RSAddRoleCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,strong) UILabel * roleLabel;
 
@property (nonatomic,strong) UITextView * textview;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,weak) id<RSAddRoleCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
