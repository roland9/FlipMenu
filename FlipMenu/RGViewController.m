//
//  RGViewController.m
//  FlipMenu
//
//  Created by RolandG on 17/11/2013.
//  Copyright (c) 2013 mapps. All rights reserved.
//

#import "RGViewController.h"
#import "RGMenuView.h"
#import <FrameAccessor.h>


@interface RGViewController ()

@end

@interface RGViewController ()
@property (nonatomic, strong) RGMenuView *menu1;
@property (nonatomic, strong) RGMenuView *menu2;
@end


@implementation RGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menu1 = [[RGMenuView alloc] initWithSize:CGSizeMake(200., 200.)
                                            text:@"Menu Help"
                                           block:^{
                                               NSLog(@"front side selected");
                                           }
                                    backsideMenus:@[ [RGMenuView menuWithText:@"Solo Play" block:^{ NSLog(@"selected solo"); }],
                                                     [RGMenuView menuWithText:@"Two Player (local)" block:^{ NSLog(@"selected two player (local)"); }],
                                                     [RGMenuView menuWithText:@"Login with Game Center" block:^{ NSLog(@"selected Game Center"); }]]
                  ];
    
    self.menu1.center = self.view.middlePoint;
    [self.menu1 setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [self.view addSubview:self.menu1];
}

@end