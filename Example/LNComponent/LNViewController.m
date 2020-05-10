//
//  LNViewController.m
//  LNComponent
//
//  Created by nanier on 11/11/2019.
//  Copyright (c) 2019 nanier. All rights reserved.
//

#import "LNViewController.h"

@interface LNViewController ()

@end

@implementation LNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor redColor];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor cyanColor];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
