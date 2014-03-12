//
//  EBPickerViewController.h
//  Cumber-Test
//
//  Created by Chip Snyder on 2/24/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *picker;
    NSArray *adjectiveWheel;
    NSArray *colorWheel;
    NSArray *nounWheel;
    NSArray *components;
}

@end
