//
//  RefreshView.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 5/11/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "RefreshView.h"

@interface RefreshView()
@property (weak, nonatomic) IBOutlet UILabel *failureLb;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
- (IBAction)tellControllerButtonPushed:(id)sender;

@end

@implementation RefreshView

+(instancetype)refreshView{

    UINib *nib = [UINib nibWithNibName:@"RefreshView" bundle:nil];
    RefreshView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}

//-(void)setDelegate:(id<RefreshViewDelegate>)delegate{
//    self.delegate = delegate;
//    
//    [self.refreshButton addTarget:delegate action:@selector(retryAccessApi) forControlEvents:UIControlEventTouchUpInside];
//
//}


- (IBAction)retryGettingInfo:(id)sender {
    
    
}

- (IBAction)tellControllerButtonPushed:(id)sender {
    
    [self.delegate retryAccessApi];
    
    NSLog(@"成功〜〜〜！");
}
@end
