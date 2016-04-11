//
//  SWParallaxViewController.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWParallaxViewController.h"
#import "ImageURL.h"
#import "SWFloatingView.h"
#import "SWMediaCell.h"
#import "SWDataRequest.h"
#import "UIImageView+FadeIn.h"

#define kFloatingMinBubblesCount 32

#define kFloatParallaxOffset 20

#define kMinSize 40
#define kMaxSize 200

#define kFloatingBubbleMinSize CGSizeMake(20,20)
#define kFloatingBubbleAverageSize CGSizeMake(35,35)
#define kFloatingBubbleMaxSize CGSizeMake(50,50)

@interface SWParallaxViewController ()

@property (strong, nonatomic) NSArray * dataSource;
@property (nonatomic) NSMutableArray* numbers;
@property (nonatomic) NSMutableArray* numberWidths;
@property (nonatomic) NSMutableArray* numberHeights;

@end


@implementation SWParallaxViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Do any additional setup after loading the view.
	[self applyParallax];
	self.dataSource = [ImageURL pickURLs];

	RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
	layout.direction = UICollectionViewScrollDirectionVertical;
	
	CGSize size;
	if (self.dataSource.count < kFloatingMinBubblesCount) {
		size = kFloatingBubbleMinSize;
	} else if (self.dataSource.count < 2 * kFloatingMinBubblesCount) {
		size = kFloatingBubbleAverageSize;
	} else {
		size = kFloatingBubbleMaxSize;
	}
	
	layout.blockPixels = size;
	layout.delegate = self;

	[self datasInit];
	[self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)datasInit {
	NSInteger count = self.dataSource.count == 0 ? kFloatingMinBubblesCount : self.dataSource.count;
	self.numbers = [@[] mutableCopy];
	self.numberWidths = @[].mutableCopy;
	self.numberHeights = @[].mutableCopy;
	for(NSInteger idx = 0; idx < count; idx++) {
		[self.numberWidths addObject:@([self randomLength])];
		[self.numberHeights addObject:@([self randomLength])];
	}
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- UIHandling

- (void)applyParallax {
	// Set vertical effect
	UIInterpolatingMotionEffect * vert = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	
	vert.minimumRelativeValue = @(-kFloatParallaxOffset);
	vert.maximumRelativeValue = @(kFloatParallaxOffset);
	
	// Set horizontal effect
	UIInterpolatingMotionEffect * horiz = [[UIInterpolatingMotionEffect alloc]
  initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	horiz.minimumRelativeValue = @(-kFloatParallaxOffset);
	horiz.maximumRelativeValue = @(kFloatParallaxOffset);
	
	// Create group to combine both
	UIMotionEffectGroup *group = [UIMotionEffectGroup new];
	group.motionEffects = @[horiz, vert];
	
	// Add both effects to view
	[self.contentView addMotionEffect:group];
}

#pragma mark- collection data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	SWMediaCell * cell = (SWMediaCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	if (self.dataSource.count) {
		ImageURL * url = (ImageURL *)self.dataSource[indexPath.row];
		[cell.imgv setAndFadeInInstagramImageWithURL:[NSURL URLWithString:url.url]];
	} else {
		if (indexPath.row % 2 == 0) {
			cell.imgv.image = [UIImage imageNamed:@"woman"];
		} else {
			cell.imgv.image = [UIImage imageNamed:@"man"];
		}
	}
	return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.dataSource.count == 0 ? kFloatingMinBubblesCount : self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

#pragma mark – RFQuiltLayoutDelegate


-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat width = [[self.numberWidths objectAtIndex:indexPath.row] floatValue];
	CGFloat height = [[self.numberWidths objectAtIndex:indexPath.row] floatValue];
	return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
	return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - Helper methods

- (NSUInteger)randomLength
{
	// always returns a random length between 1 and 3, weighted towards lower numbers.
	NSUInteger result = arc4random() % 6;
	
	// 3/6 chance of it being 1.
	if (result <= 2) {
		result = 1;
	}	else if (result == 5) { // 1/6 chance of it being 3.
		result = 3;
	} else { 	// 2/6 chance of it being 2.
		result = 2;
	}
	
	return result;
}

@end
