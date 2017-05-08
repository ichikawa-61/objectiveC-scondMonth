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


NSInteger loadNextCount = 0;
@interface ShopListViewController ()

@property (nonatomic,strong) ShopTableViewDataSource *dataSource;
@property (nonatomic,strong) HotPepperApiManager *manager;
@property (nonatomic) NSInteger scrollNumber;
//@property (nonatomic, strong) NSString *area;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation ShopListViewController

static NSString *const firstLoadNumber = @"1";


#pragma mark - private method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.area = @"五反田";
    self.navigationItem.title = @"五反田の飲食店";
    self.manager = [[HotPepperApiManager alloc]init];
    self.manager.delegate = self;
    [self.manager getShopInformation:firstLoadNumber];
    
    UINib *nib = [UINib nibWithNibName:@"ShopCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    UINib *loadNib = [UINib nibWithNibName:@"LoadNextCell" bundle:nil];
    [self.tableView registerNib:loadNib forCellReuseIdentifier:@"NextCell"];
    
    self.dataSource = [[ShopTableViewDataSource alloc]init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(actionName) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:self.refreshControl];
        //[self.indicator setHidesWhenStopped:NO];

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

//スクロールで最終行まで行ったら呼ばれる
- (void)showIndicatorOnTheBottom
{
    [self.indicator startAnimating];
    CGRect footerFrame = self.tableView.tableFooterView.frame;
    footerFrame.size.height += 10.0f;
    
    [self.indicator setFrame:footerFrame];
    [self.tableView setTableFooterView:self.indicator];
}


- (void)endIndicator
{
    [self.indicator stopAnimating];
    [self.indicator removeFromSuperview];
    
}


#pragma mark - HotPepperApiManager delegate method

-(void)finishGettingInfo:(NSMutableArray *)shopList{
    
    
    [self.dataSource setUpTableView:shopList];
    
    self.scrollNumber = shopList.count;
    [self.tableView reloadData];
    
    //インジケーターは非表示にする
    [self endIndicator];
    //[self.indicator stopAnimating];
    //[self.indicator removeFromSuperview];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row== self.scrollNumber){
        return 60;
    
    }else{
        return 200;
    }
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.scrollNumber){
        
        [self showIndicatorOnTheBottom];
    
    }


}



#pragma mark - scrollView

//スクロールするたびに呼ばれるメソッド
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    BOOL isBouncing = NO;
//    isBouncing = (self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) &  self.tableView.dragging;
//    if(isBouncing){
//        
//        //最後のせるまで行ったらインジゲーターを出す
//        [self startIndicator];
//        
//        [self.manager getShopInformation:self.area NumberOfSearch:APICount];
//        //[self startReloadData];
//        //[self startIndicator];
//    }
//}
//

//たぶんいらない
//- (void)startReloadData{
//   
//    
//    CGRect footerFrame = self.tableView.tableFooterView.frame;
//    footerFrame.size.height += 10.0f;
//    
//    UIImageView *reloadImage = [[UIImageView alloc]init];
//    reloadImage.image = [UIImage imageNamed:@"refresh"];
//    [reloadImage setFrame:footerFrame];
//    [self.tableView setTableFooterView:reloadImage];
//    
//    
//}








@end
