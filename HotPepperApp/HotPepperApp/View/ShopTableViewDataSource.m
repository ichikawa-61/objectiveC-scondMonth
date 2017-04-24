//
//  ShopTableViewDataSource.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ShopTableViewDataSource.h"
#import "ShopEntity.h"

@interface ShopTableViewDataSource()

@property (nonatomic) NSMutableArray *shops;

@end

@implementation ShopTableViewDataSource


//controllerからapi情報を受け取ってプロパティに格納
-(void)setUpTableView:(NSMutableArray<NSString*>*)shops{
    
    self.shops = shops;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ShopEntity *shop = [self.shops objectAtIndex:indexPath.row];
    
    cell.shopName.text = [NSString stringWithFormat:@"%@", shop.name];
    
   //画像のキャッシュ
    NSURL *url = [NSURL URLWithString:shop.logo];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.logoImage.image = image;
    
    return cell;
    
}


@end
