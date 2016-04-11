//
//  SWPhotoViewController.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWPhotoViewController.h"
#import "SWDataRequest.h"
#import "SWMediaTableViewCell.h"
#import "UIImageView+FadeIn.h"

@interface SWPhotoViewController ()

@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation SWPhotoViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	NSURL * url = [NSURL URLWithString:self.mediaResponse.images.standard_resolution.url];
	[self.photo setAndFadeInInstagramImageWithURL:url];
	
	[self requestComments];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- UITableView delegate

#pragma mark- UITableView datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString * cell_id = @"cell";
	
	SWMediaTableViewCell * cell = (SWMediaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
	SWCommentResponse * comment = (SWCommentResponse *)self.dataSource[indexPath.row];
	cell.commentLabel.text = comment.text;
	NSURL * url = [NSURL URLWithString:comment.from.profile_picture];
	[cell.imgv setAndFadeInInstagramImageWithURL:url];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	SWCommentResponse * comment = (SWCommentResponse *)self.dataSource[indexPath.row];
	NSString * text = comment.text;
	CGRect frame = [text boundingRectWithSize:CGSizeMake(231, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
	return MAX(frame.size.height, 65);
}

#pragma mark- Requests

- (void)requestComments {
	__weak typeof(self) weakSelf = self;
	
	[SWDataRequest feedCommentsForMediaID:self.mediaResponse.id success:^(SWCommentsResponse * object) {
		dispatch_async(dispatch_get_main_queue(), ^{
			weakSelf.dataSource = object.data;
			[weakSelf.tableView reloadData];
		});
	} failure:^(NSError * error) {
	
	}];
}

@end
