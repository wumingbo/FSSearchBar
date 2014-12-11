//
//  ViewController.m
//  FSSearchBar
//
//  Created by BruceJackson on 14/12/3.
//  Copyright (c) 2014年 BruceJackson. All rights reserved.
//

#import "ViewController.h"

#import "FSSearchBar.h"

@interface ViewController () <FSSearchBarDelegate>

@property (weak, nonatomic) IBOutlet FSSearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - FSSearchBarDelegate

- (void)FSSearchBar:(FSSearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@", searchText);
}

- (BOOL)FSSearchBarShouldBeginEditing:(FSSearchBar *)searchBar {
    [searchBar setShowCancelButton:YES animated:YES];
    
    return YES;
}

- (BOOL)FSSearchBarShouldEndEditing:(FSSearchBar *)searchBar {
    [searchBar setShowCancelButton:NO animated:YES];
    
    return YES;
}

@end
