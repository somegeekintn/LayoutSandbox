//
//  HeaderView.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/13/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint	*fullHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint	*collapsedHeight;

@end


@implementation HeaderView

- (void) setCollapsed: (BOOL) inCollapsed
{
	if (inCollapsed != _collapsed) {
		_collapsed = inCollapsed;

		self.date.hidden = inCollapsed;
		self.fullHeight.priority = inCollapsed ? 250 : 750;
		self.collapsedHeight.priority = inCollapsed ? 750 : 250;
	}
}

@end
