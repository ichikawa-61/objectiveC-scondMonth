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

@end

@interface HotPepperApiManager : NSObject

UIKIT_EXTERN NSString *const APICount;
@property (nonatomic, weak)id <APIHotpepprtDelegate>delegate;
-(void)getShopInformation:(NSString*)area NumberOfSearch:(NSString*)search;

@end
