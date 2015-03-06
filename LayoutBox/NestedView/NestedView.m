//
//  NestedView.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "NestedView.h"

@interface NestedView()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint		*heightConstraint;
@property (nonatomic, readonly) CGFloat						toggledHeight;

@end

@implementation NestedView

- (CGFloat) toggledHeight
{
	return self.heightConstraint.constant == 100.0 ? 50.0 : 100.0;
}

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

- (IBAction) toggleSize: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	self.heightConstraint.constant = self.toggledHeight;

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (IBAction) toggleSizeAnimated: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	self.heightConstraint.constant = self.toggledHeight;
	
	[UIView animateWithDuration: 1.0 animations: ^{
		[self layoutIfNeeded];
	}];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end
