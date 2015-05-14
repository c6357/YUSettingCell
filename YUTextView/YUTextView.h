//
//  YUTextView.h
//  YUSettingCell
//
//  Created by yuzhx on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>


#define WarnIgnore_Deprecate(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)

@interface YUTextView : UITextView

@property(nonatomic, retain) NSString *placeholder;// default is nil. string is drawn 70% gray

/**
 * 自动适应高度
 **/
-(void)SetToFit;

@end
