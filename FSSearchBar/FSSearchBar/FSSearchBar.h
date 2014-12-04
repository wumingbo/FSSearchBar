//
//  FSSearchBar.h
//  FSSearchBar
//
//  Created by BruceJackson on 14/12/3.
//  Copyright (c) 2014年 BruceJackson. All rights reserved.
//  By the way, the designer is SB.

#import <UIKit/UIKit.h>

@protocol FSSearchBarDelegate;

@interface FSSearchBar : UIView

/**
 *  The deleagte who implements the FSSearchBarDelegate methods.
 */
@property (weak, nonatomic) IBOutlet id <FSSearchBarDelegate> delegate;

/**
 *  The UITextField's text.
 */
@property (strong, nonatomic) NSString *text;

/**
 *  The UITextField's placeholder. Deafault is "搜索".
 */
@property (strong, nonatomic) NSString *placeholder;

/**
 *  The icon of search bar.
 */
@property (strong, nonatomic) UIImage *searchIcon;

/**
 *  The color of the textfield background color.
 */
@property (strong, nonatomic) UIColor *textfieldBackgroundColor;

/**
 *  View's tintColor.
 */
@property (strong, nonatomic) UIColor *tintColor;

/**
 *  The title of cancel button. Deafault is "取消".
 */
@property (strong, nonatomic) NSString *cancelButtonTitle;

/**
 *  The image of cancel button. Deafault is nil.
 */
@property (strong, nonatomic) UIImage *cancelButtonImage;

/**
 *  The searchBar's cancel button showing state. Default is NO.
 */
@property (assign, nonatomic, readonly) BOOL isCancelButtonShow;

/**
 *  Return a instance of FSSearchBar.
 *
 *  @return FSSearchBar.
 */
+ (instancetype)searchBar;

/**
 *  To set cancelButton showing state.
 *
 *  @param showCancelButton The property of "isCancelButtonShow" set.
 *  @param animated         Change state by animation.If the value is YES.
 */
- (void)setCancelButtonShow:(BOOL)showCancelButton animated:(BOOL)animated;

@end

@protocol FSSearchBarDelegate <NSObject>

@optional

- (BOOL)FSSearchBarShouldBeginEditing:(FSSearchBar *)searchBar;
- (BOOL)FSSearchBarShouldEndEditing:(FSSearchBar *)searchBar;

- (void)FSSearchBarTextDidBeginEditing:(FSSearchBar *)searchBar;
- (void)FSSearchBarTextDidEndEditing:(FSSearchBar *)searchBar;

- (void)FSSearchBar:(FSSearchBar *)searchBar textDidChange:(NSString *)searchText;

- (void)FSSearchBarCancelButtonClicked:(FSSearchBar *)searchBar;
- (BOOL)FSSearchBarSearchButtonClicked:(FSSearchBar *)searchBar;

@end