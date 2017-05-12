//
//  ViewController.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ShopListViewController.h"
//View
#import "ShopTableViewDataSource.h"
#import "ShopCell.h"
#import "RetryView.h"


NSInteger loadNextCount = 1;
@interface ShopListViewController ()<RetryViewDelegate>

@property (nonatomic,strong) ShopTableViewDataSource *dataSource;
@property (nonatomic,strong) HotPepperApiManager *manager;
@property (nonatomic) NSInteger scrollNumber;
@property (nonatomic, strong) RetryView *refreshView;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation ShopListViewController

static NSString *const firstLoadNumber = @"1";


#pragma mark - private method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"五反田の飲食店";
    self.manager = [[HotPepperApiManager alloc]init];
    self.manager.delegate = self;
    [self.manager getShopInformation:loadNextCount];
    
    UINib *nib = [UINib nibWithNibName:@"ShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];

    UINib *loadNib = [UINib nibWithNibName:@"LoadNextCell" bundle:nil];
    [self.tableView registerNib:loadNib forCellReuseIdentifier:@"NextCell"];

    self.dataSource = [[ShopTableViewDataSource alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    self.tableView.alwaysBounceVertical = YES;
  
    [self showIndicator];
   
}

-(void)showIndicator{
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.indicator setColor:[UIColor darkGrayColor]];
    self.indicator.center = self.view.center;
    [self.indicator startAnimating];
    [self.view addSubview:self.indicator];
    [self.view bringSubviewToFront:self.indicator];
    
}


- (void)endIndicator
{
    [self.indicator stopAnimating];
    [self.indicator removeFromSuperview];
    
}

#pragma mark - RetryViewDelegate method

-(void)retryAccessApi{

   [self.manager getShopInformation:loadNextCount];
}


#pragma mark - HotPepperApiManager delegate methods

-(void)finishGettingInfo:(NSMutableArray *)shopList{
    
    
    [self.dataSource setUpTableView:shopList CountOfLoad:loadNextCount];
    
    self.scrollNumber = shopList.count;
    if(shopList.count < 11){
        [self.tableView reloadData];
    }
    //インジケーターは非表示にする
    [self endIndicator];
}

-(void)failGettingInfo{
    
    [self endIndicator];
    
    self.refreshView = [RetryView refreshView];
    self.refreshView.delegate = self;
    [self.view addSubview:self.refreshView];
    [self.view bringSubviewToFront:self.refreshView];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == self.scrollNumber*loadNextCount){
        return 60;
    
    }else{
        return 200;
    }
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.scrollNumber*loadNextCount){
        
        loadNextCount++;
        [self.manager getShopInformation:loadNextCount];
        
        CGRect footerFrame = self.tableView.tableFooterView.frame;
        footerFrame.size.height += 10.0f;

        [self.indicator setFrame:footerFrame];
        [self.indicator startAnimating];
        [self.tableView setTableFooterView:self.indicator];
        [self.tableView reloadData];
    }
}

# pragma mark - UIRefreshController method

-(void)pullToRefresh{
    
    loadNextCount = 1;
    [self.refreshControl beginRefreshing];
    [self.manager getShopInformation:loadNextCount];
    [self.refreshControl endRefreshing];
}


@end
