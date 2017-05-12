//
//  RefreshView.h
//  HotPepperApp
//
//  Created by Manami Ichikawa on 5/11/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RetryViewDelegate

@optional
-(void)retryAccessApi;

@end

@interface RetryView : UIView

+(instancetype)refreshView;
@property(nonatomic, weak) id<RetryViewDelegate> delegate;

@end
