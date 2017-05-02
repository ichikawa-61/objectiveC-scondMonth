//
//  ViewController.h
//  HotPepperApp
//
//  Created by Manami Ichikawa on 4/24/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotPepperApiManager.h"

@interface ShopListViewController : UIViewController<UITableViewDelegate,APIHotpepprtDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

