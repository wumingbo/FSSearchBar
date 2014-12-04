//
//  FSSearchBar.m
//  FSSearchBar
//
//  Created by BruceJackson on 14/12/3.
//  Copyright (c) 2014年 BruceJackson. All rights reserved.
//

#import "FSSearchBar.h"

#define kContentViewColor [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define kTextfieldBackgroundColor [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00]
#define kBottomLineColor [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00]
#define kCyanTextColor [UIColor colorWithRed:0 / 255.0f green:187 / 255.0f blue:166 / 255.0f alpha:1]
#define kMiddleGrayTextColor [UIColor colorWithRed:102.0 / 255.0f green:102.0 / 255.0f blue:102.0 / 255.0f alpha:1]
#define kLightGrayTextColor [UIColor colorWithRed:170.0 / 255.0f green:170.0 / 255.0f blue:170.0 / 255.0f alpha:1]

#define kTextfieldBackgroundFrame CGRectMake(15, 8, self.bounds.size.width - 30, kSearchBarHeight - 16)
#define kTextfieldFrame CGRectMake(20, 8, [self placeholderWidth] + self.iconView.bounds.size.width, kSearchBarHeight - 16)
#define kCancelButtonFrame CGRectMake(self.bounds.size.width - 50, 8, 50, 34)
#define kBottomLineFrame CGRectMake(0, kSearchBarHeight - 0.5, self.bounds.size.width, 1)
#define kIconViewFrame CGRectMake(0, 0, 20, 20)

#define kTextfieldMaxWidth self.textfieldBackgroundView.bounds.size.width - 10

//static NSInteger const kAnimationDuration = 0.3;
static CGFloat const kSearchBarHeight = 50.0;
static CGFloat const kSearchBarTextfieldCornerRadius = 5.0;

@interface FSSearchBar () <UITextFieldDelegate>

@property (assign, nonatomic) BOOL isCancelButtonShow;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *textfieldBackgroundView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UITextField *textfield;
@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UIView *lineView;

@end

@implementation FSSearchBar

#pragma mark - INIT

+ (instancetype)searchBar {
    return [[FSSearchBar alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kSearchBarHeight);
        
        [self setupProperty];
        
        [self setupFrame];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kSearchBarHeight);
        
        [self setupProperty];
        
        [self setupFrame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self setupUI];
    
    [self setupProperty];
    
    [self setupFrame];
}

#pragma mark - Public Methods

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setupFrame];
}

- (void)setText:(NSString *)text {
    _text = text;
    
    self.textfield.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.textfield.placeholder = _placeholder;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    
    self.textfield.tintColor = tintColor;
    
    [self.cancelButton setTitleColor:tintColor forState:UIControlStateNormal];
}

- (void)setCancelButtonImage:(UIImage *)cancelButtonImage {
    _cancelButtonImage = cancelButtonImage;
    
    [self.cancelButton setImage:cancelButtonImage forState:UIControlStateNormal];
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    _cancelButtonTitle = cancelButtonTitle;
    
    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

- (void)setCancelButtonShow:(BOOL)showCancelButton animated:(BOOL)animated {
    if (animated) {
        if (showCancelButton && !self.isCancelButtonShow) {
            [UIView beginAnimations:@"ShowCancelButton" context:nil];
            self.textfield.frame = CGRectMake(self.textfield.frame.origin.x, self.textfield.frame.origin.y, self.textfield.frame.size.width - 35, kSearchBarHeight - 16);
            self.textfieldBackgroundView.frame = CGRectMake(self.textfieldBackgroundView.frame.origin.x, self.textfieldBackgroundView.frame.origin.y, self.textfieldBackgroundView.frame.size.width - 35, self.textfieldBackgroundView.frame.size.height);
            self.cancelButton.alpha = 1;
            [UIView commitAnimations];
            
            self.isCancelButtonShow = YES;
        } else if (!showCancelButton && self.isCancelButtonShow){
            [UIView beginAnimations:@"HideCancelButton" context:nil];
            self.cancelButton.alpha = 0;
            self.textfieldBackgroundView.frame = kTextfieldBackgroundFrame;
            self.textfield.frame = kTextfieldFrame;
            self.textfield.center = self.textfieldBackgroundView.center;
            [UIView commitAnimations];
            
            self.isCancelButtonShow = NO;
        }
    } else {
        if (showCancelButton && !self.isCancelButtonShow) {
            self.textfield.frame = CGRectMake(self.textfield.frame.origin.x, self.textfield.frame.origin.y, self.textfield.frame.size.width - 50, kSearchBarHeight - 16);
            self.textfieldBackgroundView.frame = CGRectMake(self.textfieldBackgroundView.frame.origin.x, self.textfieldBackgroundView.frame.origin.y, self.textfieldBackgroundView.frame.size.width - 35, self.textfieldBackgroundView.frame.size.height);
            self.cancelButton.alpha = 1;
            
            self.isCancelButtonShow = YES;
        } else if (!showCancelButton && self.isCancelButtonShow) {
            self.textfieldBackgroundView.frame = kTextfieldBackgroundFrame;
            self.textfield.frame = kTextfieldFrame;
            self.textfield.center = self.textfieldBackgroundView.center;
            self.cancelButton.alpha = 0;
            
            self.isCancelButtonShow = NO;
        }
    }
}

- (BOOL)becomeFirstResponder {
    return [self.textfield becomeFirstResponder];
}

- (BOOL)isFirstResponder {
    return [self.textfield isFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.textfield resignFirstResponder];
}

#pragma mark - Private Methods

- (void)setupUI {
    self.backgroundColor = kContentViewColor;
    _isCancelButtonShow = NO;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    
    _textfieldBackgroundView = [[UIView alloc] init];
    _textfieldBackgroundView.backgroundColor = kTextfieldBackgroundColor;
    _textfieldBackgroundView.layer.cornerRadius = kSearchBarTextfieldCornerRadius;
    
    _textfield = [[UITextField alloc] init];
    _textfield.returnKeyType = UIReturnKeySearch;
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textfield.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    _textfield.textColor = kMiddleGrayTextColor;
    _textfield.borderStyle = UITextBorderStyleNone;
    _textfield.delegate = self;
    [_textfield addTarget:self
                   action:@selector(didTextChange:)
         forControlEvents:UIControlEventEditingChanged];
    
    UIButton *clearButton = [_textfield valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"icon_search_cancel"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"icon_search_cancel"] forState:UIControlStateHighlighted];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.alpha = 0;
    _cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    [_cancelButton setTitleColor:kCyanTextColor forState:UIControlStateNormal];
    [_cancelButton addTarget:self
                      action:@selector(didCancelButtonClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = kBottomLineColor;
    
    [self addSubview:_contentView];
    [self addSubview:_textfieldBackgroundView];
    [self addSubview:_textfield];
    [self addSubview:_cancelButton];
    [_contentView addSubview:_lineView];
}

- (void)setupFrame {
    _contentView.frame = self.bounds;
    
    _textfieldBackgroundView.frame = kTextfieldBackgroundFrame;
    
    _textfield.frame = kTextfieldFrame;
    _textfield.center = _textfieldBackgroundView.center;
    
    _cancelButton.frame = kCancelButtonFrame;
    
    _lineView.frame = kBottomLineFrame;
}

- (void)setupProperty {
    _text = _textfield.text = @"";
    _placeholder = self.textfield.placeholder = @"搜索";
    _tintColor = self.textfield.tintColor = kCyanTextColor;
    _searchIcon = [UIImage imageNamed:@"icon_location_search"];
    _iconView = [[UIImageView alloc] initWithImage:_searchIcon];
    _cancelButtonTitle = @"取消";
    
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [self.textfield setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:_placeholder attributes:@{NSForegroundColorAttributeName: kLightGrayTextColor, NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:14]}]];
    
    UIView *leftView = [[UIView alloc] initWithFrame:kIconViewFrame];
    leftView.backgroundColor = [UIColor clearColor];
    [leftView addSubview:self.iconView];
    self.textfield.leftViewMode = UITextFieldViewModeAlways;
    self.textfield.leftView = leftView;
    self.iconView.center = leftView.center;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapGestureEvent:)];
    [self.textfieldBackgroundView addGestureRecognizer:tap];
}

- (void)tapGestureEvent:(UITapGestureRecognizer *)tap {
    if (![self.textfield isFirstResponder]) {
        [self.textfield becomeFirstResponder];
    }
}

- (void)didTextChange:(UITextField *)textfield {
    if ([self.delegate respondsToSelector:@selector(FSSearchBar:textDidChange:)]) {
        [self.delegate FSSearchBar:self textDidChange:textfield.text];
    }
}

- (void)didCancelButtonClicked:(UIButton *)cancelButton {
    
    if ([self.delegate respondsToSelector:@selector(FSSearchBarCancelButtonClicked:)]) {
        [self.delegate FSSearchBarCancelButtonClicked:self];
    }
    
    [self.textfield resignFirstResponder];
}

- (CGFloat)placeholderWidth {
    if (_placeholder.length != 0) {
        CGSize placeholderSize = [self.textfield.attributedPlaceholder boundingRectWithSize:CGSizeMake(kTextfieldMaxWidth - 10, kSearchBarHeight - 16) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        
        return placeholderSize.width + 10;
    }
    
    return 0;
}

- (void)textFieldForEditing {
    [UIView beginAnimations:@"ToEdit" context:nil];
    self.textfield.frame = kTextfieldFrame;
    [UIView commitAnimations];
    self.textfield.frame = CGRectMake(20, 8, kTextfieldMaxWidth, kSearchBarHeight - 16);
}

- (void)textFieldForNormal {
    self.textfield.frame = kTextfieldFrame;
    
    [UIView beginAnimations:@"ToNormal" context:nil];
    self.textfield.center = self.textfieldBackgroundView.center;
    [UIView commitAnimations];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self textFieldForEditing];
    
    if ([self.delegate respondsToSelector:@selector(FSSearchBarShouldBeginEditing:)]) {
        return [self.delegate FSSearchBarShouldBeginEditing:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField.text.length == 0) {
        [self textFieldForNormal];
    }
    
    textField.clearButtonMode = textField.text.length == 0 ? UITextFieldViewModeWhileEditing : UITextFieldViewModeAlways;
    
    if ([self.delegate respondsToSelector:@selector(FSSearchBarShouldEndEditing:)]) {
        return [self.delegate FSSearchBarShouldEndEditing:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(FSSearchBarSearchButtonClicked:)]) {
        return [self.delegate FSSearchBarSearchButtonClicked:self];
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(FSSearchBarTextDidBeginEditing:)]) {
        [self.delegate FSSearchBarTextDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(FSSearchBarTextDidEndEditing:)]) {
        [self.delegate FSSearchBarTextDidEndEditing:self];
    }
}

@end
