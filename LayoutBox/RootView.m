//
//  RootView.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "RootView.h"

@implementation RootView

- (void) layoutSubviews
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	
	[super layoutSubviews];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (void) updateConstraints
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	
	[super updateConstraints];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end
