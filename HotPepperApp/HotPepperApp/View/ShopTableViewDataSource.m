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

@interface ShopTableViewDataSource()

@property (nonatomic) NSCache *cache;
@property (nonatomic) NSFileManager *fileManager;
@property (nonatomic) NSString *cacheDirectory;
@property (nonatomic) NSMutableArray *shops;
@property (nonatomic) NSOperationQueue* queue;

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
    
    return self.shops.count;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    ShopEntity *shop = [self.shops objectAtIndex:indexPath.row];
    
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
    
    if(shop.logo){
        self.cache = [[NSCache alloc]init];
        self.cache.countLimit = 50;
        //NSURL *url = [NSURL URLWithString:shop.logo];
        //NSString *key = url.absoluteString;
        //NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage* image = [self.cache objectForKey:indexPath];
        
        if (image) {
            cell.logoImage.image = image;
        } else {
            
            
            //[cell.indicatorView startAnimating];
            
            NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:shop.logo]];
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//            
//            [NSURLSession dataTaskWithRequest:completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//               
//                UIImage *aImage = [UIImage imageWithData:data];
//               NSLog(@"ううううううう"); 
//                //[aCell.indicatorView stopAnimating];
//                [self.cache setObject:aImage forKey:indexPath];
//                //[collectionView reloadItemsAtIndexPaths:@[indexPath]];
//                
//                cell.logoImage.image = aImage;
//            }];
        }
        
        //UIImage *image = [UIImage imageWithData:data];
        //[self.cache setObject:image forKey:key];
        //[data writeToFile:key atomically:NO];
       // NSData *data = [NSData dataWithContentsOfURL:url];
      //  UIImage *image = [UIImage imageWithData:data];
        //cell.logoImage.image = aImage;
    }else{
     
        cell.logoImage.image = [UIImage imageNamed:@"noImage"];
    
    }
    
    return cell;
        
    
}





@end
