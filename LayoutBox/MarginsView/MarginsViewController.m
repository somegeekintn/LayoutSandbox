//
//  MarginsViewController.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "MarginsViewController.h"

@interface MarginsViewController ()

@end

@implementation MarginsViewController

- (void) viewWillLayoutSubviews
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	
	[super viewWillLayoutSubviews];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (void) viewDidLayoutSubviews
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	
	[super viewDidLayoutSubviews];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end
