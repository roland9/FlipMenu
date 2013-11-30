//
//  RGMenuView.m
//  RGMenuView
//
//  Created by RolandG on 17/11/2013.
//  Copyright (c) 2013 FM. All rights reserved.
//

#import "RGMenuView.h"

@interface RGMenuView ()
@property (copy) void (^didSelectMenuBlock) (void);
@property (nonatomic, strong) UILabel *menuLabel;
@property (nonatomic, strong) UIView *backsideMenuView;
@property (nonatomic, strong) NSArray *backsideMenus;
@property (nonatomic, assign) BOOL isFrontsideShown;
@end


@implementation RGMenuView
// factory
+ (id)menuWithText:(NSString *)menuText block:(void (^)(void))didSelectMenu {
    NSAssert(menuText, @"menuText is mandatory");
    NSAssert(didSelectMenu, @"didSelectMenu block is mandatory");
    
    RGMenuView *menu = [[RGMenuView alloc] initWithSize:CGSizeMake(80, 80) text:menuText block:didSelectMenu backsideMenus:NULL];
    return menu;
}


// init
- (id)initWithSize:(CGSize)size text:(NSString *)menuText block:(void (^)(void))didSelectMenu backsideMenus:(NSArray *)backsideMenus {

    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    self = [self initWithFrame:frame text:menuText block:didSelectMenu backsideMenus:backsideMenus];
    return self;
}

// designated initializer
- (id)initWithFrame:(CGRect)frame text:(NSString *)menuText block:(void (^)(void))didSelectMenuBlock backsideMenus:(NSArray *)backsideMenus {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor yellowColor]];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [textLabel setText:menuText];
        [textLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
        [textLabel setTextAlignment:NSTextAlignmentCenter];
        [textLabel setTextColor:[UIColor darkGrayColor]];
        [textLabel setNumberOfLines:3];
        [self addSubview:textLabel];
        self.menuLabel = textLabel;

        // create back side menu view with the menu items
        CGRect backsideMenuFrame = CGRectMake(0, 0, 200, 200);
        self.backsideMenuView = [[UIView alloc] initWithFrame:backsideMenuFrame];
        [self.backsideMenuView setBackgroundColor:[UIColor brownColor]];
        [self.backsideMenuView setHidden:YES];
        [self.backsideMenuView.layer setTransform:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
        [self addSubview:self.backsideMenuView];

        NSUInteger subMenuIndex = 0;
        for (RGMenuView *subMenuView in backsideMenus) {
            NSAssert([subMenuView isKindOfClass:[RGMenuView class]], @"expected instance RGMenuView class in backsideMenu array");
            
            CGRect frame = [self subMenuFrameWithIndex:subMenuIndex];
            [subMenuView setFrame:frame];
            [self.backsideMenuView addSubview:subMenuView];
            subMenuIndex ++;
        }
        
        self.backsideMenus = backsideMenus;
        
        self.isFrontsideShown = YES;
        self.didSelectMenuBlock = didSelectMenuBlock;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callActionBlock)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (NSString *)menuText {
    return self.menuLabel.text;
}


////////////////////////////////////////////////////////////////////
# pragma mark - Private

- (void)callActionBlock {
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        // add the rotation transform the the EXISTING transform, thereby rotating endlessly (BUT rounding error?!?)
        [self.layer setTransform:CATransform3DConcat(self.layer.transform, CATransform3DMakeRotation(M_PI_2, 0, 1, 0))];
    } completion:^(BOOL finished) {
        [self toggleStatus];
        
        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setTransform:CATransform3DConcat(self.layer.transform, CATransform3DMakeRotation(M_PI_2, 0, 1, 0))];
        } completion:^(BOOL finished) {
            self.isFrontsideShown ? self.didSelectMenuBlock() : nil; // todoRG pending - call block of background menu
        }];
    }];
}


- (void)toggleStatus {
    self.isFrontsideShown = !self.isFrontsideShown;
    [self.menuLabel setHidden:!self.isFrontsideShown];
    [self.backsideMenuView setHidden:self.isFrontsideShown];
}


- (CGRect)subMenuFrameWithIndex:(NSUInteger)index {
    CGFloat width = 90;
    CGFloat height = width;
    CGFloat xPadding = 5;
    CGFloat yPadding = xPadding;
    
    switch (index) {
        case 0:
            return CGRectMake(xPadding, yPadding, width, height);
            break;
            
        case 1:
            return CGRectMake(width+2.*xPadding, yPadding, width, height);
            break;

        case 2:
            return CGRectMake(xPadding, height+2.*yPadding, width, height);
            break;

        case 3:
            return CGRectMake(width+xPadding, height+2.*yPadding, width, height);
            break;

        default:
            NSAssert(NO, @"inconsistent - expected 0 <= index <= 3");
            return CGRectMake(0, 0, 10, 10);
            break;
    }
}


@end
