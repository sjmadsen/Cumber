//
//  UILabel+CumberExtension.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/12/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "UILabel+CumberExtension.h"

@implementation UILabel (CumberExtension)

- (NSString *)accessibilityValue
{
    return self.text;
}

@end
