//
//  CollectionViewController.m
//  LayoutBox
//
//  Created by Casey Fleser on 3/6/15.
//  Copyright (c) 2015 Quiet Spark. All rights reserved.
//

#import "CollectionViewController.h"
#import "ContainerView.h"
#import "HeaderView.h"

@interface CollectionSizingController ()

@property (nonatomic, weak) IBOutlet HeaderView		*header;
@property (nonatomic, weak) IBOutlet ContainerView	*containerCell;

@end

@implementation CollectionSizingController
@end

@interface CollectionViewController ()

@property (nonatomic, strong) CollectionSizingController	*sizingController;
@property (nonatomic, weak) IBOutlet UICollectionView		*collectionView;
@property (nonatomic, assign) BOOL							expanded;

@end

@implementation CollectionViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
}

#pragma mark - Getters / Setters

- (CollectionSizingController *) sizingController
{
	if (_sizingController == nil) {
		UIView		*view;
		
		_sizingController = [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"CollectionContainer"];
		[_sizingController loadView];

		view = _sizingController.containerCell;
		[view addConstraint: [NSLayoutConstraint constraintWithItem: view attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: [self collectionViewContentWidth]]];

		view = _sizingController.header;
		[view addConstraint: [NSLayoutConstraint constraintWithItem: view attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: CGRectGetWidth(self.collectionView.frame)]];
	}
	
	return _sizingController;
}

#pragma mark - Helpers

- (NSString *) titleForItemAtIndexPath: (NSIndexPath *) inIndexPath
{
	NSString	*word = self.expanded ? @"xxxxxx " : @"xxx ";
	NSString	*title = word;
	
	for (NSInteger idx=0; idx<inIndexPath.row; idx++) {
		title = [title stringByAppendingString: word];
	}
	
	return title;//[NSString stringWithFormat: @"Item: %d", (int)inIndexPath.row];
}

- (CGFloat) collectionViewContentWidth
{
	UICollectionViewFlowLayout	*flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;

	return CGRectGetWidth(self.collectionView.frame) - (flowLayout.sectionInset.left + flowLayout.sectionInset.right);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger) numberOfSectionsInCollectionView: (UICollectionView *) inCollectionView
{
	return 3;
}

- (NSInteger) collectionView: (UICollectionView *) inCollectionView
	numberOfItemsInSection: (NSInteger) inSection
{
	return 4;
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

- (UICollectionReusableView *)collectionView: (UICollectionView *) inCollectionView
	viewForSupplementaryElementOfKind: (NSString *) inKind
	atIndexPath: (NSIndexPath *) inIndexPath
{
	UICollectionReusableView		*reusableView = [inCollectionView dequeueReusableSupplementaryViewOfKind: inKind withReuseIdentifier: @"MainHeader" forIndexPath: inIndexPath];
	HeaderView						*headerView = (HeaderView *)[[reusableView subviews] firstObject];

	headerView.collapsed = inIndexPath.section != 0 ? YES : NO;
	headerView.title.text = [NSString stringWithFormat: @"Sub-title %d", inIndexPath.section + 1];
	
	NSLog(@"%s: viewForSupplementaryElementOfKind %@ - %@", __PRETTY_FUNCTION__, inKind, inIndexPath);
	NSLog(@"%s: reusableView %p", __PRETTY_FUNCTION__, reusableView);
	NSLog(@"%s: headerView.title.text %p = %@", __PRETTY_FUNCTION__, headerView, headerView.title.text);
	NSLog(@"%s: inIndexPath %@", __PRETTY_FUNCTION__, inIndexPath);
	
	return reusableView;
}

- (CGSize) collectionView: (UICollectionView *) inCollectionView
	layout: (UICollectionViewLayout *) inCollectionViewLayout
	referenceSizeForHeaderInSection: (NSInteger) inSection
{
	HeaderView			*headerView = self.sizingController.header;
	CGSize				headerSize;
	
	headerView.collapsed = inSection != 0 ? YES : NO;
	headerSize = [headerView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];

	NSLog(@"%s: headerSize %@", __PRETTY_FUNCTION__, NSStringFromCGSize(headerSize));

	return headerSize;
}

- (CGSize) collectionView: (UICollectionView *) inCollectionView
	layout: (UICollectionViewLayout *) inCollectionViewLayout
	sizeForItemAtIndexPath: (NSIndexPath *) inIndexPath
{
	NSLog(@"%s: enter", __PRETTY_FUNCTION__);
	ContainerView				*containerView;
	CGSize						cellSize;
	
	containerView = self.sizingController.containerCell;
	containerView.title.text = [self titleForItemAtIndexPath: inIndexPath];
	cellSize = [containerView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
	
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
