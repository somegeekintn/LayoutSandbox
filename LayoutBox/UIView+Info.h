//
//  UIView+Info.h
//  LayoutBox
//
//  Created by Casey Fleser on 3/30/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Info)

- (void)		displayInfoToDepth: (NSInteger) inMaxDepth
					currentDepth: (NSInteger) inCurDepth;
- (NSInteger)	showLayoutStatus;
- (void)		compareWithSystemFittingSize;

@end
