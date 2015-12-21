

//
//  SettingCell.m
//  YUSettingCell
//
//  Created by yuzhx on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *accessorySwitch;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UITextField *describeTexField;
@property (weak, nonatomic) IBOutlet YUTextView *describeTexView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (nonatomic,strong) SettingInfo *setInfo;
@end

@implementation SettingCell
- (void)awakeFromNib
{
    // Initialization code
    self.iconImg.layer.borderWidth = 0.65f;
    self.iconImg.layer.cornerRadius = 8.0f;
    self.iconImg.layer.borderColor = [[UIColor colorWithWhite:.8 alpha:1.0] CGColor];
    self.iconImg.layer.masksToBounds = YES;
    
    [self.describeTexField setTextColor:[UIColor darkGrayColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)setSetInfo:(SettingInfo *)setInfo
{
    _setInfo = setInfo;
    
    self.titleLab.text = setInfo.title;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (setInfo.action && setInfo.handle){
        [setInfo.handle performSelector:setInfo.action withObject:nil];
    }
#pragma clang diagnostic po
    
    
    self.accessorySwitch.hidden = YES;
    self.accessoryView = nil;
    switch (setInfo.accView) {
        case ACCV_Accessory:
        {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
            
        case ACCV_None:
        {
            self.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
            
        case ACCV_Switch:
        {
            self.accessoryView = self.accessorySwitch;
            self.accessorySwitch.hidden = NO;
            [self.accessorySwitch setOn:setInfo.switchON animated:false];
            self.accessorySwitch.userInteractionEnabled = setInfo.switchEnable;
        }
            break;
            
        default:
            self.accessoryType = UITableViewCellAccessoryNone;
            break;
    }

    
    ///////////////desrc
    self.describeTexField.userInteractionEnabled = NO;
    self.describeTexView.userInteractionEnabled = NO;
    if (setInfo.handle) {
        switch (setInfo.inputTextType) {
            case Input_TextField:
            {
                self.describeTexField.delegate = setInfo.handle;
                self.describeTexField.text = setInfo.describe;
                self.describeTexField.userInteractionEnabled = !setInfo.textEnable;
            }
                break;
                
            case Input_TextView:
            {
                self.describeTexView.delegate = setInfo.handle;
                self.describeTexView.text = setInfo.describe;
                self.describeTexView.userInteractionEnabled = !setInfo.textEnable;
            }
                break;
                
            default:
                break;
        }
    }
    
    
   
    //////////////frame
    CGFloat X = 5 + [self LabSize:self.titleLab.font labTex:self.titleLab.text].width +self.titleLab.frame.origin.x;
    CGRect frame = CGRectMake(X,self.describeTexField.frame.origin.y, self.frame.size.width - X, self.frame.size.height);
    self.describeTexField.frame = frame;
    self.describeTexField.backgroundColor = [UIColor clearColor];
    
    self.describeTexView.frame = frame;
    self.describeTexView.backgroundColor = [UIColor clearColor];
    
    self.iconImg.hidden = setInfo.iconImg ? NO : YES;
    self.iconImg.image = setInfo.iconImg;
    
    frame = self.titleLab.frame;
    frame.origin.x = setInfo.iconImg ? 60 : 15;
    self.titleLab.frame = frame;
}


#pragma mark - Event Handler -
- (IBAction)textfieldEvent:(UITextField*)sender {
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock(((UITextField*)sender).text);
    }
    self.setInfo.describe = sender.text;
}


-(IBAction)textViewDidChange:(UITextView *)textView{
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock(textView.text);
    }
    self.setInfo.describe = textView.text;
}


- (IBAction)switchEvent:(UISwitch*)sender {
    if (self.setInfo.eventBlock) {
        self.setInfo.eventBlock((UISwitch*)sender);
    }
    self.setInfo.switchON = sender.on;
}


#pragma mark - Private -
-(CGSize)LabSize:(UIFont*)Labfont labTex:(NSString*)Text{
    NSDictionary * attribute = [NSDictionary dictionaryWithObjectsAndKeys:Labfont,NSFontAttributeName,nil];
    CGSize actualsize = [Text boundingRectWithSize:CGSizeMake(self.frame.size.width, 10000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    actualsize.width += 8;
    return actualsize;
}
@end

@implementation SettingInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = nil;
        self.describe = nil;
        self.action = nil;
        self.handle = nil;
        self.switchON = YES;
        self.switchEnable = YES;
        self.textEnable = YES;
        
        self.accView = ACCV_None;
        self.accView = Input_TextField;
    }
    return self;
}
@end
