//
//  TableViewController.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

// Note: Using a very contrived example here to directly set the height of a cell.
//       A more typical approach would be to define the spacing between various
//       elements inside the cell's content view and allow auto-layout to derive
//       the height that way.
//
// Another note: Some good notes here: http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()

@property (nonatomic, weak) IBOutlet UITableView	*tableView;
@property (nonatomic, assign) BOOL					expanded;

@end

@implementation TableViewController

- (void) viewDidLoad
{
	[super viewDidLoad];

	self.tableView.estimatedRowHeight = 50.0;
}

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

#pragma mark - Helpers

- (NSString *) titleForItemAtIndexPath: (NSIndexPath *) inIndexPath
{
	return [NSString stringWithFormat: @"Item: %d", (int)inIndexPath.row];
}

- (CGFloat) heightForItemAtIndexPath: (NSIndexPath *) inIndexPath
{
	return (self.expanded ? 60.0 : 40.0) + inIndexPath.row * 5.0;
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView: (UITableView *) inTableView
	numberOfRowsInSection: (NSInteger) inSection
{
	return 10;
}

- (UITableViewCell *) tableView: (UITableView *) inTableView
	cellForRowAtIndexPath: (NSIndexPath *) inIndexPath
{
	TableViewCell		*cell = (TableViewCell *)[inTableView dequeueReusableCellWithIdentifier: @"TableViewCell" forIndexPath: inIndexPath];
	
	cell.label.text = [self titleForItemAtIndexPath: inIndexPath];
	cell.heightConstraint.constant = [self heightForItemAtIndexPath: inIndexPath];
	
	return cell;
}

#pragma mark - UITableViewDelegate

// Note: A cell's constraints affecting the vertical axis must not be required as the system will
//       have created its own required constraint based on the height defined in the storyboard
//       This UIView-Encapsulated-Layout-Height will eventually get reset, but not before emitting
//       lots of unsatisfiable constraint noise beforehand

- (CGFloat) tableView: (UITableView *) inTableView
	heightForRowAtIndexPath: (NSIndexPath *) inIndexPath
{
	static TableViewCell	*sSizingCell = nil;
	CGSize					cellSize;
	
	if (sSizingCell == nil) {
		sSizingCell = [inTableView dequeueReusableCellWithIdentifier: @"TableViewCell"];
	}
	
	sSizingCell.heightConstraint.constant = [self heightForItemAtIndexPath: inIndexPath];
	cellSize = [sSizingCell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
	
	NSLog(@"size %@ for %@", NSStringFromCGSize(cellSize), inIndexPath);

	return cellSize.height;
}

#pragma mark - Actions

- (IBAction) toggleSize: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	self.expanded = !self.expanded;
	[self.tableView reloadData];
	
	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (IBAction) toggleSizeAnimated: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	self.expanded = !self.expanded;
	
	[UIView beginAnimations: @"Custom table view resize duration" context: nil];
	[UIView setAnimationDuration: 0.5];

	// No need for reloading, etc. beginUpdates will query all the new sizes and update as needed
	[self.tableView beginUpdates];
	[self.tableView endUpdates];
	[UIView commitAnimations];

	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end
