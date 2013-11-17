//
//  RGMenuView.m
//  RGMenuView
//
//  Created by RolandG on 17/11/2013.
//  Copyright (c) 2013 FM. All rights reserved.
//

#import "RGMenuView.h"

@interface RGMenuView ()
@property (copy) void (^didSelectForegroundMenuBlock) (void);
@property (copy) void (^didSelectBackgroundMenuBlock) (void);
@property (nonatomic, strong) UILabel *foregroundLabel;
@property (nonatomic, strong) UILabel *backgroundLabel;
@property (nonatomic, assign) BOOL isForegroundShown;
@end


@implementation RGMenuView

- (id)initWithFrame:(CGRect)frame foregroundText:(NSString *)foregroundText backgroundText:(NSString *)backgroundText foregroundMenuBlock:(void (^)(void))didSelectForegroundMenuBlock backgroundMenuBlock:(void (^)(void))didSelectBackgroundMenuBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor yellowColor]];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [textLabel setText:foregroundText];
        [textLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
        [textLabel setTextAlignment:NSTextAlignmentCenter];
        [textLabel setTextColor:[UIColor darkGrayColor]];
        [self addSubview:textLabel];
        _foregroundLabel = textLabel;
        
        UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [textLabel2 setText:backgroundText];
        [textLabel2 setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
        [textLabel2 setTextAlignment:NSTextAlignmentCenter];
        [textLabel2 setTextColor:[UIColor blueColor]];
        [textLabel2.layer setTransform:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
        [self addSubview:textLabel2];
        _backgroundLabel = textLabel2;
        [_backgroundLabel setHidden:YES];
        
        _isForegroundShown = YES;
        _didSelectForegroundMenuBlock = didSelectForegroundMenuBlock;
        _didSelectBackgroundMenuBlock = didSelectBackgroundMenuBlock;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callActionBlock)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)callActionBlock {
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        // add the rotation transform the the EXISTING transform, thereby rotating endlessly (BUT rounding error?)
        [self.layer setTransform:CATransform3DConcat(self.layer.transform, CATransform3DMakeRotation(M_PI_2, 0, 1, 0))];
    } completion:^(BOOL finished) {
        [self toggleStatus];
        
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setTransform:CATransform3DConcat(self.layer.transform, CATransform3DMakeRotation(M_PI_2, 0, 1, 0))];
        } completion:^(BOOL finished) {
            _isForegroundShown ? _didSelectBackgroundMenuBlock() : _didSelectForegroundMenuBlock();
        }];
    }];
}


- (void)toggleStatus {
    _isForegroundShown = !_isForegroundShown;
    [self showBackground:!_isForegroundShown];
}


- (void)showBackground:(BOOL)shouldShowBackground {
    [_backgroundLabel setHidden:!shouldShowBackground];
    [_foregroundLabel setHidden:shouldShowBackground];
    _isForegroundShown = !shouldShowBackground;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
