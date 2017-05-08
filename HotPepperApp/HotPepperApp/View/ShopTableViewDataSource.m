//
//  ShopTableViewDataSource.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.


//View
#import "ShopTableViewDataSource.h"
//Model
#import "ShopEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ShopTableViewDataSource()

@property (nonatomic) NSCache *cache;
@property (nonatomic) NSFileManager *fileManager;
@property (nonatomic) NSString *cacheDirectory;
@property (nonatomic) NSMutableArray *shops;
@property (nonatomic) NSOperationQueue* queue;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@end

@implementation ShopTableViewDataSource



# pragma mark - UITableViewDataSource

//controllerからapi情報を受け取ってプロパティに格納
-(void)setUpTableView:(NSMutableArray<NSString*>*)shops{
    
    self.shops = shops;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = self.shops.count;
    
    NSLog(@"%ld",count );
    return count +1;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.shops.count){
        
        UITableViewCell *loadNextCell = [UITableViewCell new];
        loadNextCell.textLabel.text = @"さらに読み込む";
        
        return loadNextCell;
    }else{
        
        ShopEntity *shop = [self.shops objectAtIndex:indexPath.row];
        static NSString *CellIdentifier = @"Cell";
        ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        cell.nameLabel.text    = [NSString stringWithFormat:@"%@", shop.name];
        cell.genreLabel.text   = [NSString stringWithFormat:@"%@", shop.genre];
        cell.foodLabel.text    = [NSString stringWithFormat:@"%@", shop.food];
        cell.openLabel.text    = [NSString stringWithFormat:@"%@", shop.open];
        cell.budgetLabel.text  = [NSString stringWithFormat:@"%@", shop.averageBudget];
        cell.accessLabel.text  = [NSString stringWithFormat:@"%@", shop.access];
        cell.addressLabel.text = [NSString stringWithFormat:@"%@", shop.address];
        
        cell.budgetIcon.image  = [UIImage imageNamed:@"money"];
        cell.openIcon.image    = [UIImage imageNamed:@"time"];
        cell.accessIcon.image  = [UIImage imageNamed:@"train"];
        cell.addressIcon.image = [UIImage imageNamed:@"map"];
        
        NSURL *url = [NSURL URLWithString:shop.logo];
        UIImage *placeholderImage = [UIImage imageNamed:@"noImage"];
                    [cell.logoImage sd_setImageWithURL:url
                   placeholderImage:placeholderImage];
        
       return cell;
        
    }
    
    
    
}





@end
