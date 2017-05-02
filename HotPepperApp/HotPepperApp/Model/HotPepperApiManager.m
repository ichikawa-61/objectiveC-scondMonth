//
//  HotPepperApiManager.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.


//Model
#import "HotPepperApiManager.h"
#import "ShopEntity.h"
#import "AreaNameEncoder.h"
//ライブラリ
#import <AFNetworking/AFNetworking.h>

@implementation HotPepperApiManager

static NSString *const Url = @"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?";

static NSString *const APIKey    = @"bc37ec7b3d44efe0";

static NSString *const APIFormat = @"json";
static NSString *const ShopId = @"id";
static NSString *const ShopName = @"name";
static NSString *const Access = @"access";
static NSString *const Opening = @"open";
static NSString *const Address = @"address";
NSString *const  APICount  = @"50";

static NSString *const FoodNamePath  = @"food.name";
static NSString *const AverageBudgetPath = @"budget.average";
static NSString *const GenreNamePath = @"genre.name";
static NSString *const LogoPath = @"photo.mobile.l";


# pragma mark - Api method
-(void)getShopInformation:(NSString*)area NumberOfSearch:(NSString*)search{
    
    AreaNameEncoder *encoder = [[AreaNameEncoder alloc]init];
    NSString * encodedArea = [encoder encodeAreaName:area];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:Url
      parameters:@{@"key"     :APIKey,
                   @"count"   :APICount,
                   @"keyword" :encodedArea,
                   @"format"  :APIFormat,
                   @"start"   :search}
     
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             NSMutableArray<ShopEntity *> *shopEntityList = [[NSMutableArray alloc]init];
             
             NSDictionary *results = responseObject[@"results"];
             NSDictionary *shopDict    = results[@"shop"];
             
             for (NSDictionary<NSString *, NSString *> *shop in shopDict){
                 ShopEntity *shopEntity = [[ShopEntity alloc]init];
                 shopEntity.shopId  = shop[ShopId];
                 shopEntity.name    = shop[ShopName];
                 shopEntity.open    = shop[Opening];
                 shopEntity.address = shop[Address];
                 shopEntity.access  = shop[Access];
                 shopEntity.food    = [shop valueForKeyPath:FoodNamePath];
                 shopEntity.averageBudget
                 = [shop valueForKeyPath:AverageBudgetPath];
                 shopEntity.genre   = [shop valueForKeyPath:GenreNamePath];
                 shopEntity.logo    = [shop valueForKeyPath: LogoPath];
                 
                 NSLog(@"%@",shopEntity.name);
                 NSLog(@"%@",shopEntity.averageBudget);
                 NSLog(@"%@",shopEntity.address);
                 
                 [shopEntityList addObject:shopEntity];
             }
             
             if ([self.delegate respondsToSelector:@selector(finishGettingInfo:)]) {
                
                 [self.delegate finishGettingInfo:shopEntityList];
             }
                      
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"通信に失敗しました: %@", error);
         }];

}



@end
