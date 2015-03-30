//
//  UIView+Info.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/30/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "UIView+Info.h"

@implementation UIView (Info)

- (void) displayInfoToDepth: (NSInteger) inMaxDepth
	currentDepth: (NSInteger) inCurDepth
{
	NSString	*pad = @"";
	
	for (NSInteger idx=0; idx<inCurDepth; idx++) {
		pad = [pad stringByAppendingString: @"\t"];
	}

	NSLog(@"%@%@", pad, self);
	pad = [pad stringByAppendingString: @"\t"];

	for (id constraint in self.constraints) {
		NSLog(@"%@c:%@", pad, constraint);
	}

	if (inMaxDepth == -1 || inCurDepth < inMaxDepth) {
		for (id subView in self.subviews) {
			[subView displayInfoToDepth: inMaxDepth currentDepth: inCurDepth + 1];
		}
	}
}

- (NSInteger) showLayoutStatus
{
	NSInteger	depth = 0;
	NSString	*pad = @"";
	
	if (self.superview != nil) {
		depth = [self.superview showLayoutStatus];
	}

	for (NSInteger idx=0; idx<depth; idx++) {
		pad = [pad stringByAppendingString: @"\t"];
	}

	NSLog(@"%@%@: %@", pad, NSStringFromClass([self class]), self.layer.needsLayout ? @"layout" : @"-");
	
	return depth + 1;
}

- (void) compareWithSystemFittingSize
{
	CGSize	compressedSize = [self systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
	CGSize	expandedSize = [self systemLayoutSizeFittingSize: UILayoutFittingExpandedSize];

	NSLog(@"%@ - actual size: %@ / compressed size %@ / expanded size %@", NSStringFromClass([self class]), NSStringFromCGSize(self.bounds.size), NSStringFromCGSize(compressedSize), NSStringFromCGSize(expandedSize));
}

@end
