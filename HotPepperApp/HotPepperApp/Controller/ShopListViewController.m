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


@interface ShopListViewController ()

@property (nonatomic,strong) ShopTableViewDataSource *dataSource;
@property (nonatomic,strong) HotPepperApiManager *manager;
@property (nonatomic) NSInteger scrollNumber;
@property (nonatomic, strong) NSString *area;

@end

@implementation ShopListViewController

static NSString *const firstLoadNumber = @"1";


#pragma mark - private method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.area = @"五反田";
    self.navigationItem.title = @"五反田の飲食店";
    self.manager = [[HotPepperApiManager alloc]init];
    self.manager.delegate = self;
    [self.manager getShopInformation:self.area NumberOfSearch:firstLoadNumber];
    
    UINib *nib = [UINib nibWithNibName:@"ShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    self.dataSource = [[ShopTableViewDataSource alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
   
}



#pragma mark - HotPepperApiManager delegate method

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
        
        //NSInteger nextInfo =
        [self.manager getShopInformation:self.area NumberOfSearch:APICount];
        [self startReloadData];
    }
}


- (void)startReloadData{
   
    
    CGRect footerFrame = self.tableView.tableFooterView.frame;
    footerFrame.size.height += 10.0f;
    
    UIImageView *reloadImage = [[UIImageView alloc]init];
    reloadImage.image = [UIImage imageNamed:@"refresh"];
    [reloadImage setFrame:footerFrame];
    [self.tableView setTableFooterView:reloadImage];
    
    
}








@end
