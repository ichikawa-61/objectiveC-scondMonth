//
//  ViewController.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ShopListViewController.h"
//#import "ShopEntity.h"
#import "HotPepperApiManager.h"
#import "ShopTableViewDataSource.h"
#import "ShopCell.h"


@interface ShopListViewController ()

@property (nonatomic,strong) ShopTableViewDataSource *dataSource;

@end

@implementation ShopListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *area = @"五反田";
    HotPepperApiManager *manager = [[HotPepperApiManager alloc]init];
    [manager getShopInformation:area];
    
    UINib *nib = [UINib nibWithNibName:@"ShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    self.dataSource = [[ShopTableViewDataSource alloc]init];
    self.tableView.dataSource = self.dataSource;
    

    
    
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end
