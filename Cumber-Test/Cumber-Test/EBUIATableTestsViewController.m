//
//  EBUIATableTestsViewController.m
//  Cumber-Test
//
//  Created by Chip Snyder on 2/24/14.
//  Copyright (c) 2014 Education. All rights reserved.
//

#import "EBUIATableTestsViewController.h"

@implementation EBUIATableTestsViewController

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        [self setTitle:@"UIATable Tests"];
        sectionOne = [NSArray arrayWithObjects:@"Ohio", @"New York", @"Washington", @"Pennsylvania", nil];
        sectionTwo = [NSArray arrayWithObjects:@"Columbus", @"Cleveland", @"Seattle", @"Rochester", @"Pittsburgh", nil];
        sections = [NSArray arrayWithObjects:sectionOne, sectionTwo, nil];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[self tableView] setAccessibilityLabel:@"citiesAndStates"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    switch (section)
    {
        case 0:
            title = @"States";
            break;
            
        case 1:
            title = @"Cities";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:[[sections objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]]];
    
    return cell;
}



@end
