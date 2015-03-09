//
//  CollectionViewController.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "CollectionViewController.h"
#import "ContainerView.h"

@interface CollectionViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView	*collectionView;
@property (nonatomic, assign) BOOL						expanded;

@end

@implementation CollectionViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
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
	NSString	*word = self.expanded ? @"xxxxx" : @"xxx ";
	NSString	*title = word;
	
	for (NSInteger idx=0; idx<inIndexPath.row; idx++) {
		title = [title stringByAppendingString: word];
	}
	
	return title;//[NSString stringWithFormat: @"Item: %d", (int)inIndexPath.row];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger) collectionView: (UICollectionView *) inCollectionView
	numberOfItemsInSection: (NSInteger) inSection
{
	return 10;
}

- (UICollectionViewCell *) collectionView: (UICollectionView *) inCollectionView
	cellForItemAtIndexPath: (NSIndexPath *) inIndexPath
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	UICollectionViewCell		*cell = [inCollectionView dequeueReusableCellWithReuseIdentifier: @"CollectionViewCell" forIndexPath: inIndexPath];
	ContainerView				*containerView = (ContainerView *)[[cell.contentView subviews] firstObject];
	
	if (containerView != nil) {
		containerView.title.text = [self titleForItemAtIndexPath: inIndexPath];
	}
	
	return cell;
}

- (CGSize) collectionView: (UICollectionView *) inCollectionView
	layout: (UICollectionViewLayout *) inCollectionViewLayout
	sizeForItemAtIndexPath: (NSIndexPath *) inIndexPath
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	static UIViewController		*sSizingController = nil;
	ContainerView				*containerView;
	CGSize						cellSize;
	
	if (sSizingController == nil) {
		sSizingController = [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"CollectionContainer"];
	}
	
	containerView = (ContainerView *)sSizingController.view;
	containerView.title.text = [self titleForItemAtIndexPath: inIndexPath];
	cellSize = [sSizingController.view systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
	
	NSLog(@"size %@ for %@", NSStringFromCGSize(cellSize), inIndexPath);

	return cellSize;
}

#pragma mark - Actions

- (IBAction) toggleSize: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);

	self.expanded = !self.expanded;
	[self.collectionView reloadData];
	
	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

- (IBAction) toggleSizeAnimated: (id) inSender
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	ContainerView				*containerView;
	
	self.expanded = !self.expanded;
	for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
		NSIndexPath	*indexPath = [self.collectionView indexPathForCell: cell];
		
		if (indexPath != nil) {
			containerView = (ContainerView *)[[cell.contentView subviews] firstObject];
			containerView.title.text = [self titleForItemAtIndexPath: indexPath];
		}
	}
	
	[UIView beginAnimations: @"Custom collection view resize duration" context: nil];
	[UIView setAnimationDuration: 0.5];
	
	[self.collectionView performBatchUpdates: ^{
		[self.collectionView.collectionViewLayout invalidateLayout];
	} completion: nil];
	
	[UIView commitAnimations];

//	[self.collectionView performBatchUpdates: ^{
//		[self.collectionView reloadSections: [NSIndexSet indexSetWithIndex: 0]];
//	} completion: nil];
//
//	[self.collectionView performBatchUpdates: ^{
//		[self.collectionView reloadData];
//	} completion: nil];
//	
	NSLog(@"%s: exit", __PRETTY_FUNCTION__);
}

@end
