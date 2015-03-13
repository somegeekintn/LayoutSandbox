//
//  HeaderView.h
//  LayoutBox
//
//  Created by Casey Fleser on 3/13/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property (nonatomic, weak) IBOutlet UILabel			*date;
@property (nonatomic, weak) IBOutlet UILabel			*title;
@property (nonatomic, assign) BOOL						collapsed;

@end
