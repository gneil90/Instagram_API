//
//  SWBaseViewController.h
//  swift_inst
//
//  Created by Galiaskarov Neil on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWBaseViewController : UIViewController

@property (assign, nonatomic, setter=setIsLoading:) BOOL isLoading;

- (IBAction)backButtonPressed:(id)sender;

@end
