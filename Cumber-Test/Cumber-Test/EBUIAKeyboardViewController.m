//
//  EBUIAKeyboardViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 1/24/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIAKeyboardViewController.h"

@implementation EBUIAKeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setTitle:@"UIAKeyboard Tests"];
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    return self;
}

@end
