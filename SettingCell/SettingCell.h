//
//  SettingCell.h
//  YUSettingCell
//
//  Created by yuzhx on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUTextView.h"

typedef enum : NSUInteger {
    ACCV_None,
    ACCV_Accessory,
    ACCV_UISwitch
} SetInfoAccType;

typedef void (^NillBlock_OBJ)(id obj);
typedef void (^NillBlock_Nill)(void);



@class SettingInfo;
@interface SettingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *accessorySwitch;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UITextField *describeTexField;
@property (weak, nonatomic) IBOutlet YUTextView *describeTexView;

@property (weak, nonatomic) IBOutlet UIImageView *IconImg;


@property (nonatomic,strong) SettingInfo *setInfo;

-(void)setSetInfo:(SettingInfo *)setInfo;
@end




@interface SettingInfo : NSObject

@property (nonatomic,strong) NSString *Title;//主题

@property (nonatomic,strong) NSString *Describe;//描述

@property (nonatomic,strong) UIImage *IconImg;

@property (nonatomic,assign) BOOL DescribeOnlyShow;//描述

@property (nonatomic,assign) BOOL isTextField;//默认输入控件为textfield 由于不想影响以前的使用，新增textView

@property (nonatomic,assign) BOOL switchOPen;
@property (nonatomic,assign) BOOL enableSwitch;

@property (nonatomic, assign)  SetInfoAccType accView;

@property (nonatomic,copy) NillBlock_OBJ eventBlock;

@property (nonatomic,copy) NillBlock_Nill didSelectRowBlock;


@property (nonatomic, assign) id handle;
@property (nonatomic, assign) SEL SELAction;
@end
