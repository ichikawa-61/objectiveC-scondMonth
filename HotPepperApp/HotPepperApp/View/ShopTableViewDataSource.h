//
//  ShopTableViewDataSource.h
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCell.h"
#import "LoadNextCell.h"
//#import <SDWebImage/UIImageView+WebCache.h>
@interface ShopTableViewDataSource : NSObject<UITableViewDataSource>

-(void)setUpTableView:(NSMutableArray<NSString*>*)shops CountOfLoad:(NSInteger)count;

@end
