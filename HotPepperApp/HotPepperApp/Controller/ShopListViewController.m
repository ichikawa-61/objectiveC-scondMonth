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
@property (nonatomic) NSInteger scrollNumber;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSString *area;

@end

@implementation ShopListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.area = @"五反田";
    self.navigationItem.title = @"五反田の飲食店";
    self.manager = [[HotPepperApiManager alloc]init];
    self.manager.delegate = self;
    [self.manager getShopInformation:self.area NumberOfSearch:1];
    
    UINib *nib = [UINib nibWithNibName:@"ShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    self.dataSource = [[ShopTableViewDataSource alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
   
}



-(void)finishGettingInfo:(NSMutableArray *)shopList{
    
    [self.dataSource setUpTableView:shopList];
    
    self.scrollNumber = shopList.count;
    [self.tableView reloadData];


}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


#pragma mark - scrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //
    BOOL isBouncing = NO;
    isBouncing = (self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) &  self.tableView.dragging;
    if(isBouncing){
        [self.manager getShopInformation:self.area NumberOfSearch:51];
    
    }
        
        
}
//
//- (NSString *)searchNumberCast
//{
//    // 表示件数の取得
//    NSUserDefaults *searchNumbserSetting = [NSUserDefaults standardUserDefaults];
//    int searchNum = (APICount + 1) * 10;
//    
//    NSLog(@"いいいいいいいい%d",searchNum);
//    NSString *sSearchNum = [NSString stringWithFormat:@"%d", searchNum];
//    
//    NSLog(@"uuuuuuuuuuuuuuu%@",sSearchNum);
//    return  sSearchNum;
//}
//
//// 検索開始値を永続化した値から確定
//- (NSString *)loadStartNumber:(NSInteger)loadNextNumber
//{
//    NSInteger loadStartNum = [[self searchNumberCast] intValue] + ((loadNextNumber -1) * 10) + 1;
//    NSString *loadStartStr = [NSString stringWithFormat:@"%ld",loadStartNum];
//    return loadStartStr;
//}
//









@end
