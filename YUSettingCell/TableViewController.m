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
//    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:Nil] forCellReuseIdentifier:@"cellIdentifier"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    }
    
    
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)configSetInfo{
    settingInfoMarry = [NSMutableArray array];
    NSArray *setInfoArry  = nil;
    /////////////////////////////////////////////////////////
    //Section 0
    SettingInfo *info0 = [[SettingInfo alloc] init];
    info0.title = @"Airplane Mode";
    info0.accView = ACCV_Switch;
    info0.switchON = YES;
    info0.eventBlock = ^(UISwitch* switchEvent){
        
    };
    
    SettingInfo *info1 = [[SettingInfo alloc] init];
    info1.title = @"Sounds";
    info1.accView = ACCV_Switch;
    info1.switchON = YES;
    info1.switchEnable = YES;
    info1.eventBlock = ^(UISwitch* switchEvent){
    };
    
    
    SettingInfo *info2 = [[SettingInfo alloc] init];
    info2.title = @"Vibrate";
    info2.accView = ACCV_Switch;
    info2.switchON = YES;
    info2.switchEnable = YES;
    info2.eventBlock = ^(UISwitch* switchEvent){
        
    };
    
    SettingInfo *info3 = [[SettingInfo alloc] init];
    info3.title = @"WLAN";
    info3.describe = @"Wi-fi";
    info3.accView = ACCV_Accessory;
    info3.didSelectRowBlock = ^{
        [self ShowInfo:@"Wi-fi"];
    };
    
    
    SettingInfo *info3_1 = [[SettingInfo alloc] init];
    info3_1.title = @"input text";
    info3_1.accView = ACCV_None;
    info3_1.textEnable = YES;
    info3_1.eventBlock = ^(UISwitch* switchEvent){
        
    };
    
    setInfoArry = [[NSArray alloc] initWithObjects:info3_1,info0,info1,info2,info3, nil];
    [settingInfoMarry addObject:setInfoArry];
    
    
    /////////////////////////////////////////////////////////
    //Section 1
    SettingInfo *info4 = [[SettingInfo alloc] init];
    info4.title = @"Genneral";
    info4.accView = ACCV_Accessory;
    info4.didSelectRowBlock = ^{
        [self ShowInfo:@"Genneral"];
    };
    
    
    SettingInfo *info5 = [[SettingInfo alloc] init];
    info5.title = @"About";
    info5.accView = ACCV_Accessory;
    info5.iconImg = [UIImage imageNamed:@"swift.jpg"];
    info5.didSelectRowBlock = ^{
        [self ShowInfo:@"About"];
    };
    
    SettingInfo *info6 = [[SettingInfo alloc] init];
    info6.title = @"Welcome";
    info6.iconImg = [UIImage imageNamed:@"swift.jpg"];
    info6.accView = ACCV_Accessory;
    info6.didSelectRowBlock = ^{
        [self ShowInfo:@"Welcome"];
    };
    
    
    SettingInfo *info7 = [[SettingInfo alloc] init];
    info7.title = @"Version";
    info7.describe = @"V.1.0";
    info7.accView = ACCV_Accessory;
    info7.didSelectRowBlock = ^{
        [self ShowInfo:@"Version"];
    };
    
    
    SettingInfo *info8 = [[SettingInfo alloc] init];
    info8.title = @"Cache";
    info8.describe = @"1M";
    info8.accView = ACCV_None;
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

