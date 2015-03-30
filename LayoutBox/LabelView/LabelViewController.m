//
//  LabelViewController.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/30/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "LabelViewController.h"
#import "UIView+Info.h"

@interface LabelViewController ()

@property (nonatomic, assign) BOOL				useLongLabel;
@property (nonatomic, weak) IBOutlet UILabel	*label;

@end


@implementation LabelTopContainer

- (void) layoutSubviews
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	[self compareWithSystemFittingSize];
	
	[super layoutSubviews];
	
	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end

@implementation LabelContainerA

- (void) layoutSubviews
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	[self compareWithSystemFittingSize];

	[super layoutSubviews];
	
	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end

@implementation LabelContainerB

- (void) layoutSubviews
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	[self compareWithSystemFittingSize];

	[super layoutSubviews];
	
	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end

@implementation LayoutLabel

- (void) layoutSubviews
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	[self compareWithSystemFittingSize];

	[self adjustPreferredMaxLayoutFromConstraints];
	
	[super layoutSubviews];
	
	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (BOOL) adjustPreferredMaxLayoutFromConstraints
{
	UIView		*superView = self.superview;
	BOOL		didAdjust = NO;


	if (superView != nil) {
		CGFloat	expecetedPreferredMaxLayout = CGRectGetMaxX(superView.bounds) - CGRectGetMinX(self.frame);
		
		for (NSLayoutConstraint *constraint in self.constraints) {
			if (constraint.firstAttribute == NSLayoutAttributeTrailing && constraint.secondAttribute == NSLayoutAttributeTrailing) {
				if ((constraint.firstItem == self && constraint.secondItem == superView) || (constraint.secondItem == self && constraint.firstItem == superView)) {
					expecetedPreferredMaxLayout -= constraint.constant;
				}
			}
		}
		
		if (self.preferredMaxLayoutWidth != expecetedPreferredMaxLayout) {
			self.preferredMaxLayoutWidth = expecetedPreferredMaxLayout;
			NSLog(@"%s: %f", __PRETTY_FUNCTION__, expecetedPreferredMaxLayout);
			didAdjust = YES;
		}
	}
	
	return didAdjust;
}

@end

@implementation LabelViewController

- (void) viewDidLoad
{
	UIView			*observedView = self.label;
	
	[super viewDidLoad];
	
	while (observedView != nil) {
		[observedView addObserver: self forKeyPath: @"bounds" options: 0 context: nil];
		[observedView addObserver: self forKeyPath: @"center" options: 0 context: nil];
		observedView = observedView.superview;
	}

	self.useLongLabel = NO;
}

- (void) viewWillLayoutSubviews
{
	NSLog(@"----");
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

- (IBAction) toggle: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	self.useLongLabel = !self.useLongLabel;

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (IBAction) toggleAnimated: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	self.useLongLabel = !self.useLongLabel;

	[self.view setNeedsLayout];
	[UIView animateWithDuration: 1.0 animations: ^{
		[self.view layoutIfNeeded];
	}];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (void) setUseLongLabel: (BOOL) inUseLongLabel
{
	_useLongLabel = inUseLongLabel;
	self.label.text = _useLongLabel ? @"We are using a very long label here" : @"short label";

NSLog(@"layout now");
	[self.view layoutIfNeeded];
NSLog(@"layout complete");
	
//	self.label.preferredMaxLayoutWidth = _useLongLabel ? 200 : 100;
//	[self.label setNeedsLayout];
//	[self.label showLayoutStatus];
//	self.label.preferredMaxLayoutWidth = self.label.preferredMaxLayoutWidth - 10;
//	self.label.text = [self.label.text stringByAppendingString: @" word"];
//	[self.label showLayoutStatus];
}

- (void) observeValueForKeyPath: (NSString *) inKeyPath
	ofObject: (id) inObject
	change: (NSDictionary *) inChange
	context: (void *) inContext
{
	if ([inObject isKindOfClass: [UIView class]]) {
		UIView		*view = inObject;
		
		NSLog(@"%@: %@", NSStringFromClass([view class]), NSStringFromCGRect(view.frame));
	}
}

@end
