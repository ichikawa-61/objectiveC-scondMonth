//
//  HotPepperApiManager.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "HotPepperApiManager.h"
#import "ShopEntity.h"
#import <AFNetworking/AFNetworking.h>

@implementation HotPepperApiManager

static NSString *const Url = @"https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?";

NSString *const APIKey    = @"bc37ec7b3d44efe0";
NSString *const APICount  = @"50";
NSString *const APIFormat = @"json";


NSString *const ShopId = @"id";
NSString *const ShopName = @"name";
NSString *const Access = @"access";
NSString *const Opening = @"open";
NSString *const Address = @"address";

NSString *const FoodNamePath  = @"food.name";
NSString *const AverageBudgetPath = @"budget.average";
NSString *const GenreNamePath = @"genre.name";
NSString *const LogoPath = @"photo.mobile.l";



-(void)getShopInformation:(NSString*)area{

//エンコード
[area stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];

AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
[manager GET:Url
  parameters:@{@"key" :APIKey,
               @"count" : APICount,
               @"keyword" :area,
               @"format" :APIFormat}
    progress:nil
     success:^(NSURLSessionTask *task, id responseObject) {
         
         NSMutableArray *shopEntityList = [[NSMutableArray alloc]init];
         
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
             
             [shopEntityList addObject:shopEntity];
         }
         
         if ([self.delegate respondsToSelector:@selector(finishGettingInfo:)]) {
            
             [self.delegate finishGettingInfo:shopEntityList];
         }
                  
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"エラー: %@", error);
     }];

}

@end
