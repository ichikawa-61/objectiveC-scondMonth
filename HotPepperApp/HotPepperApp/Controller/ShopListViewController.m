//
//  ViewController.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ShopListViewController.h"
//#import "ShopEntity.h"
//#import "HotPepperApiManager.h"
#import "ShopTableViewDataSource.h"
#import "ShopTableViewDelegate.h"
#import "ShopCell.h"


@interface ShopListViewController ()

@property (nonatomic,strong) ShopTableViewDataSource *dataSource;
@property (nonatomic,strong) ShopTableViewDelegate *tableViewDelegate;
@property (nonatomic,strong) HotPepperApiManager *manager;

@end

@implementation ShopListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *area = @"五反田";
    self.navigationItem.title = @"五反田の飲食店";
    self.manager = [[HotPepperApiManager alloc]init];
    self.manager.delegate = self;
    [self.manager getShopInformation:area];
    
    UINib *nib = [UINib nibWithNibName:@"ShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    self.dataSource = [[ShopTableViewDataSource alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
   
}



-(void)finishGettingInfo:(NSMutableArray *)shopList{
    
    [self.dataSource setUpTableView:shopList];
    
    [self.tableView reloadData];


}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}







@end
