

//
//  SettingCell.m
//  YUSettingCell
//
//  Created by yuzhx on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell()<UITextViewDelegate>
@end

@implementation SettingCell
- (void)awakeFromNib
{
    // Initialization code
    self.IconImg.layer.borderWidth = 0.65f;
    self.IconImg.layer.cornerRadius = 8.0f;
    self.IconImg.layer.borderColor = [[UIColor colorWithWhite:.8 alpha:1.0] CGColor];
    self.IconImg.layer.masksToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setSetInfo:(SettingInfo *)setInfo
{
    _setInfo = setInfo;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessorySwitch.hidden = YES;
    self.accessoryView = nil;
    
    if(setInfo.accView == ACCV_Accessory){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(setInfo.accView == ACCV_None){
        self.accessoryType = UITableViewCellAccessoryNone;
        
    }else{
        self.accessoryView = self.accessorySwitch;
        self.accessorySwitch.hidden = NO;
        [self.accessorySwitch setOn:setInfo.switchOPen animated:false];
        self.accessorySwitch.userInteractionEnabled = setInfo.enableSwitch;
    }
    //    if (setInfo.SELAction && setInfo.handle){
    //        [setInfo.handle performSelector:setInfo.SELAction withObject:nil];
    //    }
    
    self.titleLab.text = setInfo.Title;
    
    
    ///////////////desrc
    self.describeTexView.delegate = self;
    if (setInfo.handle) {
        if (setInfo.isTextField) {
            self.describeTexField.delegate = setInfo.handle;
        }else{
            self.describeTexView.delegate = setInfo.handle;
        }
    }
    
    
    self.describeTexView.userInteractionEnabled = NO;
    if (setInfo.isTextField) {
        self.describeTexField.text = setInfo.Describe;
        self.describeTexField.userInteractionEnabled = !setInfo.DescribeOnlyShow;
    }else{
        self.describeTexView.text = setInfo.Describe;
        self.describeTexView.userInteractionEnabled = !setInfo.DescribeOnlyShow;
    }
    
    
    //////////////frame
    CGFloat X = 5 + [self LabSize:self.titleLab.font labTex:self.titleLab.text].width +self.titleLab.frame.origin.x;
    self.describeTexField.frame = CGRectMake(X,self.describeTexField.frame.origin.y, 290 - X, self.frame.size.height);
    self.describeTexField.backgroundColor = [UIColor clearColor];
    
    self.describeTexView.frame = CGRectMake(X, self.describeTexView.frame.origin.y, 290 - X, self.frame.size.height);
    self.describeTexView.backgroundColor = [UIColor clearColor];
    
    self.IconImg.hidden = setInfo.IconImg ? NO : YES;
    self.IconImg.image = setInfo.IconImg;
    
    CGRect frame = self.titleLab.frame;
    frame.origin.x = setInfo.IconImg ? 60 : 15;
    self.titleLab.frame = frame;
    
}


#pragma mark - Event Handler -
- (IBAction)textfieldEvent:(UITextField*)sender {
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock(((UITextField*)sender).text);
    }
    self.setInfo.Describe = sender.text;
}

-(void)textViewDidChange:(UITextView *)textView{
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock(textView.text);
    }
    self.setInfo.Describe = textView.text;
}


- (IBAction)switchEvent:(UISwitch*)sender {
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock((UISwitch*)sender);
    }
    self.setInfo.switchOPen = sender.on;
}


#pragma mark - Private -
-(CGSize)LabSize:(UIFont*)Labfont labTex:(NSString*)Text{
    
    NSDictionary * attribute = [NSDictionary dictionaryWithObjectsAndKeys:Labfont,NSFontAttributeName,nil];
    CGSize actualsize = [Text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]applicationFrame].size.width, 10000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    actualsize.width += 2;
    return actualsize;
}

@end





@implementation SettingInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Title = nil;
        self.Describe = nil;
        self.DescribeOnlyShow = YES;
        self.SELAction = nil;
        self.handle = nil;
        self.accView = ACCV_None;
        self.enableSwitch = YES;
        self.isTextField = YES;
    }
    return self;
}
@end
