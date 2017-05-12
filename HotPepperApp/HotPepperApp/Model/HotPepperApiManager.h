//
//  HotPepperApiManager.h
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol  APIHotpepprtDelegate<NSObject>

@optional

-(void)finishGettingInfo:(NSMutableArray *)shopList;
-(void)failGettingInfo;

@end

@interface HotPepperApiManager : NSObject

@property (nonatomic, weak)id <APIHotpepprtDelegate>delegate;
-(void)getShopInformation:(NSInteger)search;

@end
