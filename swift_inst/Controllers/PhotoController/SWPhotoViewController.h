//
//  SWPhotoViewController.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWBaseViewController.h"
@class SWMediaResponse;

@interface SWPhotoViewController : SWBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (weak, nonatomic) IBOutlet UIImageView * photo;

@property (strong, nonatomic) SWMediaResponse * mediaResponse;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint * textLabelWidth;


@end
