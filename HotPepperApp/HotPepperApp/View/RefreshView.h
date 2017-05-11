//
//  RefreshView.h
//  HotPepperApp
//
//  Created by Manami Ichikawa on 5/11/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshViewDelegate

@optional
-(void)retryAccessApi;

@end

@interface RefreshView : UIView

+(instancetype)refreshView;
@property(nonatomic, weak) id<RefreshViewDelegate> delegate;

@end
