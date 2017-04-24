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



@interface ShopListViewController ()

@end

@implementation ShopListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *area = @"五反田";
    HotPepperApiManager *manager = [[HotPepperApiManager alloc]init];
    [manager getShopInformation:area];
    
    
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


@end
