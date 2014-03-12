//
//  EBPickerViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 2/24/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBPickerViewController.h"

@implementation EBPickerViewController

- (id)init
{
    self = [super init];
    if (self)
    {
         [self setEdgesForExtendedLayout:UIRectEdgeNone];
        [self setUpPicker];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    adjectiveWheel = [NSArray arrayWithObjects:@"Tiny", @"Small", @"Average", @"Large", @"Huge", nil];
    colorWheel = [NSArray arrayWithObjects:@"Yellow", @"Green", @"Blue", @"Purple", @"Red", @"Orange", nil];
    nounWheel = [NSArray arrayWithObjects:@"Elephant", @"Mouse", @"Dog", @"Cat", @"Turtle", nil];
    
    components = [NSArray arrayWithObjects:adjectiveWheel, colorWheel, nounWheel, nil];
}

-(void)setUpPicker
{
    CGRect viewFrame = [[self view] frame];
    picker = [[UIPickerView alloc] initWithFrame:viewFrame];
    [picker setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [picker setAccessibilityLabel:@"itemPicker"];
    [[self view] addSubview:picker];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [components count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[components objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[components objectAtIndex:component] objectAtIndex:row];
}

@end
