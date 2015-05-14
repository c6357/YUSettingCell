//
//  TableViewController.m
//  YUSettingCell
//
//  Created by yuzhx on 15/5/14.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "SettingCell.h"
#import "TableViewController.h"

@interface TableViewController ()
{
    NSMutableArray *settingInfoMarry;
}
@property (weak, nonatomic) IBOutlet UIView *FooterView;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
    [self configSetInfo];
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.tableFooterView = self.FooterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [settingInfoMarry count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[settingInfoMarry objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    backVIew.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return backVIew;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  section ? 20 :0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:Nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    [cell.describeTexField setTextColor:[UIColor darkGrayColor]];
    SettingInfo *setInfo = [[settingInfoMarry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell setSetInfo:setInfo];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingInfo *setInfo = [[settingInfoMarry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if(setInfo.didSelectRowBlock){
        setInfo.didSelectRowBlock();
    }
}

-(void)configSetInfo{
    settingInfoMarry = [NSMutableArray array];
    NSArray *setInfoArry  = nil;
    /////////////////////////////////////////////////////////
    //Section 0
    SettingInfo *info0 = [[SettingInfo alloc] init];
    info0.Title = @"Airplane Mode";
    info0.accView = ACCV_UISwitch;
    info0.switchOPen = YES;
    info0.eventBlock = ^(UISwitch* switchEvent){
        
    };
    
    SettingInfo *info1 = [[SettingInfo alloc] init];
    info1.Title = @"Sounds";
    info1.accView = ACCV_UISwitch;
    info1.switchOPen = YES;
    info1.enableSwitch = YES;
    info1.eventBlock = ^(UISwitch* switchEvent){
    };
    
    
    SettingInfo *info2 = [[SettingInfo alloc] init];
    info2.Title = @"Vibrate";
    info2.accView = ACCV_UISwitch;
    info2.switchOPen = YES;
    info2.enableSwitch = YES;
    info2.eventBlock = ^(UISwitch* switchEvent){
        
    };
    
    SettingInfo *info3 = [[SettingInfo alloc] init];
    info3.Title = @"WLAN";
    info3.DescribeOnlyShow = YES;
    info3.Describe = @"Wi-fi";
    info3.accView = ACCV_Accessory;
    info3.didSelectRowBlock = ^{
        [self ShowInfo:@"Wi-fi"];
    };
    
    
    SettingInfo *info3_1 = [[SettingInfo alloc] init];
    info3_1.Title = @"input text";
    info3_1.accView = ACCV_None;
    info3_1.DescribeOnlyShow = NO;
    info3_1.eventBlock = ^(UISwitch* switchEvent){
        
    };
    
    setInfoArry = [[NSArray alloc] initWithObjects:info3_1,info0,info1,info2,info3, nil];
    [settingInfoMarry addObject:setInfoArry];
    
    
    /////////////////////////////////////////////////////////
    //Section 1
    SettingInfo *info4 = [[SettingInfo alloc] init];
    info4.Title = @"Genneral";
    info4.accView = ACCV_Accessory;
    info4.didSelectRowBlock = ^{
        [self ShowInfo:@"Genneral"];
    };
    
    
    SettingInfo *info5 = [[SettingInfo alloc] init];
    info5.Title = @"About";
    info5.accView = ACCV_Accessory;
    info5.IconImg = [UIImage imageNamed:@"swift.jpg"];
    info5.didSelectRowBlock = ^{
        [self ShowInfo:@"About"];
    };
    
    SettingInfo *info6 = [[SettingInfo alloc] init];
    info6.Title = @"Welcome";
    info6.IconImg = [UIImage imageNamed:@"swift.jpg"];
    info6.accView = ACCV_Accessory;
    info6.didSelectRowBlock = ^{
        [self ShowInfo:@"Welcome"];
    };
    
    
    SettingInfo *info7 = [[SettingInfo alloc] init];
    info7.Title = @"Version";
    info7.Describe = @"V.1.0";
    info7.accView = ACCV_Accessory;
    info7.didSelectRowBlock = ^{
        [self ShowInfo:@"Version"];
    };
    
    
    SettingInfo *info8 = [[SettingInfo alloc] init];
    info8.Title = @"Cache";
    info8.Describe = @"1M";
    info8.accView = ACCV_Accessory;
    info8.didSelectRowBlock = ^{
        [self ShowInfo:@"Cache"];
    };
    
    setInfoArry = [[NSArray alloc] initWithObjects:info4,info5,info6,info7,info8,nil];
    [settingInfoMarry addObject:setInfoArry];
}

-(void)ShowInfo:(NSString*)info
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
@end

