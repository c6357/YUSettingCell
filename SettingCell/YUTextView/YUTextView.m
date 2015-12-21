//
//  YUTextView.m
//  YUSettingCell
//
//  Created by BruceYu on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//


#import "YUTextView.h"

@interface YUTextView()
@property (nonatomic, retain) UIColor* realTextColor;
@property (nonatomic, readonly) NSString* realText;
- (void) beginEditing:(NSNotification*) notification;
- (void) endEditing:(NSNotification*) notification;
@end

@implementation YUTextView
@synthesize placeholder;

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
    self.realTextColor = [UIColor blackColor];
}


-(void)SetToFit
{
    NSString *currentText = self.text;
    CGRect TitleRect = self.frame;
    CGSize actualsize;
    if(([[[UIDevice currentDevice] systemVersion] intValue]>6)){
        
        NSDictionary * attribute = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
        actualsize = [currentText boundingRectWithSize:CGSizeMake(self.frame.size.width, 980) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
    }else{
        WarnIgnore_Deprecate(actualsize = [currentText sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 980)lineBreakMode:NSLineBreakByWordWrapping];);
    }
    TitleRect.size.height = actualsize.height+10;
    self.frame = TitleRect;
}

#pragma mark -
#pragma mark Setter/Getters

- (void) setPlaceholder:(NSString *)aPlaceholder {
    if ([self.realText isEqualToString:placeholder]) {
        self.text = aPlaceholder;
    }
    
    placeholder = aPlaceholder;
    
    [self endEditing:nil];
}

- (NSString *) text {
    NSString* text = [super text];
    if ([text isEqualToString:self.placeholder]) return @"";
    return text;
}

- (void) setText:(NSString *)text {
    if ([text isEqualToString:@""] || text == nil) {
        super.text = self.placeholder;
    }
    else {
        super.text = text;
    }
    
    if ([text isEqualToString:self.placeholder]) {
        self.textColor = [UIColor lightGrayColor];
    }
    else {
        self.textColor = self.realTextColor;
    }
}

- (NSString *) realText {
    return [super text];
}

- (void) beginEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:self.placeholder]) {
        super.text = nil;
        self.textColor = self.realTextColor;
    }
}

- (void) endEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:@""] || self.realText == nil) {
        super.text = self.placeholder;
        self.textColor = [UIColor lightGrayColor];
    }
}

- (void) setTextColor:(UIColor *)textColor {
    if ([self.realText isEqualToString:self.placeholder]) {
        if ([textColor isEqual:[UIColor lightGrayColor]]) [super setTextColor:textColor];
        else self.realTextColor = textColor;
    }else {
        self.realTextColor = textColor;
        [super setTextColor:textColor];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
