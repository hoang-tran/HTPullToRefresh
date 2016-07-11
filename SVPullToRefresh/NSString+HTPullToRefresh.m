//
//  NSString+Extensions.m
//  HTPullToRefreshDemo
//
//  Created by Hoang Tran on 7/11/16.
//  Copyright © 2016 Hoang Tran. All rights reserved.
//

#import "NSString+HTPullToRefresh.h"

@implementation NSString (HTPullToRefresh)

- (CGSize)sizeWithFont:(UIFont *)font constraintToSize:(CGSize)constrainedSize {
    CGRect rect;

    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        rect = [self boundingRectWithSize:constrainedSize
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:font}
                                  context:nil];
    }
    else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        CGSize size = [self sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
        rect = CGRectMake(0, 0, size.width, size.height);
#pragma GCC diagnostic pop
    }
    return rect.size;
}

@end
