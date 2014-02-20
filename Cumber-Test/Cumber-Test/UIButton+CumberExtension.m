//
//  UIButton+CumberExtension.m
//  Cumber-Test
//
//  Created by Chip Snyder on 2/19/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "UIButton+CumberExtension.h"

@implementation UIButton (CumberExtension)

- (NSString *)accessibilityIdentifier
{
    return self.titleLabel.text;
}

@end
