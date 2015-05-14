//
//  YUTextView.h
//  YUSettingCell
//
//  Created by yuzhx on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUTextView : UITextView

@property(nonatomic, retain) NSString *placeholder;// default is nil. string is drawn 70% gray

/**
 * 自动适应高度
 **/
-(void)SetToFit;

@end
