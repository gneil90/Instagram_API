//
//  SWBaseViewController.m
//  swift_inst
//
//  Created by Galiaskarov Neil on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWBaseViewController.h"

@interface SWBaseViewController ()

@end

@implementation SWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark- IBActions

- (IBAction)backButtonPressed:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Custom setters/accessors

- (void)setIsLoading:(BOOL)isLoading {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = isLoading;

	if (isLoading == _isLoading) {
		return;
	}
	
	_isLoading = isLoading;
}

@end
