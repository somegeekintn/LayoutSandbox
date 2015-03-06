//
//  TableViewCell.h
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel				*label;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint		*heightConstraint;

@end
