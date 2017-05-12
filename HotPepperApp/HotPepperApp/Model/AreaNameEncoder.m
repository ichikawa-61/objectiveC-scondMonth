//
//  AreaNameEncoder.m
//  HotPepperApp
//
//  Created by Manami Ichikawa on 5/2/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "AreaNameEncoder.h"

@implementation AreaNameEncoder

#pragma mark - private method
-(NSString*)encodeAreaName:(NSString*)area{

    [area stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    
    return area;
}
@end
