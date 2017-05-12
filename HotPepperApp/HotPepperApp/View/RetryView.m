//
//  RefreshView.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 5/11/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "RetryView.h"

@interface RetryView()
@property (weak, nonatomic) IBOutlet UILabel *failureLb;
- (IBAction)tellControllerButtonPushed:(id)sender;

@end

@implementation RetryView

#pragma mark - initialize view method

+(instancetype)refreshView{

    UINib *nib = [UINib nibWithNibName:@"RefreshView" bundle:nil];
    RetryView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}

- (IBAction)tellControllerButtonPushed:(id)sender {
    
    [self.delegate retryAccessApi];
}

@end
