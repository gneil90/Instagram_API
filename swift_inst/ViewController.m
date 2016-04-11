//
//  ViewController.m
//  swift_inst
//
//  Created by Yan Saraev on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "ViewController.h"
#import "SWDataRequest.h"
#import "SWMediaCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "SWPhotoViewController.h"
#import "TSMessage.h"
#import "MBProgressHUD.h"

@interface ViewController () <CHTCollectionViewDelegateWaterfallLayout>

@property (strong, nonatomic) NSMutableArray * dataSource;
@property (strong, nonatomic) NSMutableArray * pages;
@property (strong, nonatomic) UIRefreshControl * refreshControl;

@property (strong, nonatomic) SWUserResponse * user;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.dataSource = [NSMutableArray array];
	self.pages = [NSMutableArray array];
	
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	[refreshControl addTarget:self action:@selector(startRefresh:)
					 forControlEvents:UIControlEventValueChanged];
	[self.collectionView addSubview:refreshControl];
	
	self.refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark- Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.destinationViewController isKindOfClass:[SWPhotoViewController class]]) {
		SWPhotoViewController * photo = (SWPhotoViewController *)segue.destinationViewController;
		NSIndexPath * indexPath = [self.collectionView indexPathForCell:sender];
		SWMediaResponse * media = (SWMediaResponse *)self.dataSource[indexPath.row];
		photo.mediaResponse = media;
	}
}

#pragma mark- UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.dataSource.count;
}


#pragma mark- UICollectionView DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	static NSString * cell_id = @"cell";
	SWMediaResponse * media = (SWMediaResponse *)self.dataSource[indexPath.row];
	SWImageResolution * resolution = media.images.standard_resolution;

	SWMediaCell * cell = (SWMediaCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
	NSURL * url = [NSURL URLWithString:resolution.url];
	[cell.imgv setAndFadeInInstagramImageWithURL:url];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	SWMediaResponse * media = (SWMediaResponse *)self.dataSource[indexPath.row];
	SWImageResolution * resolution = media.images.standard_resolution;
	
	CGSize size = CGSizeMake([resolution.width floatValue]/[UIScreen mainScreen].scale, [resolution.height floatValue]/[UIScreen mainScreen].scale);
	return size;
}

#pragma mark- ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (scrollView.contentOffset.y + CGRectGetHeight(scrollView.frame) > scrollView.contentSize.height) {
		[self loadNextPage];
	}
}

#pragma mark- IBActions

- (IBAction)searchPressed:(id)sender {
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Type username" delegate:self cancelButtonTitle:@"start" otherButtonTitles:@"cancel", nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
	UITextField * alertTextField = [alert textFieldAtIndex:0];
	alertTextField.placeholder = @"instagram username";

	[alert show];
}

#pragma mark- UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	alertView.delegate = nil;
	if (self.isLoading) {
		return;
	}

	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"start"]) {
		MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		hud.dimBackground = YES;
		UITextField *username = [alertView textFieldAtIndex:0];
		[self startRefresh:username.text];
	}
}

#pragma mark- Requests

- (void)startRefresh:(id)sender {
	if (self.isLoading) {
		return;
	}
	
	[self.refreshControl beginRefreshing];
	self.isLoading = YES;
	
	__weak typeof(self) weakSelf = self;
	
	if ([sender isKindOfClass:[NSString class]]) {
		self.user = nil;
		[SWDataRequest searchUsername:sender success:^(SWUserResponse * user) {
			weakSelf.user = user;
			[weakSelf performSelectorOnMainThread:@selector(requestFeed:)
																 withObject:nil
															waitUntilDone:NO];
		} failure:^(NSError * err) {
			[self handleError:err];
		}];
	} else if (self.user) {
		[self performSelectorOnMainThread:@selector(requestFeed:)
															 withObject:nil
														waitUntilDone:NO];
	} else {
		[self.refreshControl endRefreshing];
	}
}

- (void)requestFeed:(id)sender {
	__weak typeof(self) weakSelf = self;

	[SWDataRequest feedForUserId:self.user.id success:^(SWUserFeedResponse * feed) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[weakSelf.pages removeAllObjects];
			[weakSelf.dataSource removeAllObjects];
			[weakSelf.refreshControl endRefreshing];

			weakSelf.navigationItem.title = self.user.username;
			weakSelf.dataSource = [feed.data mutableCopy];
			if (![weakSelf.pages containsObject:feed.pagination]) {
				[weakSelf.pages addObject:feed.pagination];
			}
			[weakSelf.collectionView reloadData];
			[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
			weakSelf.isLoading = NO;
		});
	} failure:^(NSError * error) {
		[self handleError:error];
	}];
}

- (void)handleNextPage:(SWUserFeedResponse *)feed {
	dispatch_async(dispatch_get_main_queue(), ^{
		self.isLoading = NO;

		if (![self.pages containsObject:feed.pagination]) {
			[self.pages addObject:feed.pagination];
			[self.collectionView performBatchUpdates:^{
				NSMutableArray * indexes = [NSMutableArray array];
				for (SWMediaResponse * media in feed.data) {
					if ([self.dataSource containsObject:media]) {
						continue;
					}
					[self.dataSource addObject:media];
					NSIndexPath * newIndexPath = [NSIndexPath indexPathForItem:(self.dataSource.count - 1)
																													 inSection:0];
					[indexes addObject:newIndexPath];
			}
				[self.collectionView insertItemsAtIndexPaths:indexes];
			} completion:NULL];
		}
	});
}

- (void)handleError:(NSError *)error {
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.refreshControl endRefreshing];
		if (error) {
			[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
			[TSMessage showNotificationWithTitle:NSLocalizedString(@"Error", nil)
																	subtitle:[NSString stringWithFormat:@"Error code:%@", [@(error.code) stringValue]]
																			type:TSMessageNotificationTypeError];
			self.isLoading = NO;
		}
	});
}

- (void)loadNextPage {
	SWPaginationResponse * pagination = (SWPaginationResponse *)[self.pages lastObject];
	if (!pagination || self.isLoading) {
		[self handleError:nil];
		return;
	}
	
	self.isLoading = YES;

	[SWDataRequest loadFeedNextPage:pagination.next_url success:^(SWUserFeedResponse * feed) {
		[self handleNextPage:feed];
	} failure:^(NSError * error) {
		[self handleError:error];
	}];
}
@end
