//
//  ViewController.h
//  swift_inst
//
//  Created by Yan Saraev on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWBaseViewController.h"

@interface ViewController : SWBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView * collectionView;

@end

