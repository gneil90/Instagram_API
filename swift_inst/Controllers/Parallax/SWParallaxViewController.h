//
//  SWParallaxViewController.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWBaseViewController.h"
#import "RFQuiltLayout.h"

@interface SWParallaxViewController : SWBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, RFQuiltLayoutDelegate>

@property (weak, nonatomic) IBOutlet UIView * contentView;
@property (weak, nonatomic) IBOutlet UICollectionView * collectionView;


@end
