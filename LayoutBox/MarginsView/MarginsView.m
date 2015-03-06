//
//  MarginsView.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "MarginsView.h"

@interface MarginsView()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint		*topMarginConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint		*bottomMarginConstraint;
@property (nonatomic, readonly) CGFloat						toggledMargin;

@end

@implementation MarginsView

- (CGFloat) toggledMargin
{
	return self.topMarginConstraint.constant == 100.0 ? 150.0 : 100.0;
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

	CGFloat		newMargin = self.toggledMargin;
	
	self.topMarginConstraint.constant = newMargin;
	self.bottomMarginConstraint.constant = newMargin;

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (IBAction) toggleSizeAnimated: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	CGFloat		newMargin = self.toggledMargin;

	self.topMarginConstraint.constant = newMargin;
	self.bottomMarginConstraint.constant = newMargin;
	
	[UIView animateWithDuration: 1.0 animations: ^{
		[self layoutIfNeeded];
	}];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end
