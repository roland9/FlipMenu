//
//  RGMenuView.h
//  RGMenuTest
//
//  Created by RolandG on 17/11/2013.
//  Copyright (c) 2013 FM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGMenuView : UIView

@property (nonatomic, readonly) NSString *menuText;

+ (id)menuWithText:(NSString *)menuText block:(void (^)(void))didSelectMenu;
- (id)initWithFrame:(CGRect)frame text:(NSString *)menuText block:(void (^)(void))didSelectMenuBlock backsideMenus:(NSArray *)backsideMenus;
- (id)initWithSize:(CGSize)size text:(NSString *)menuText block:(void (^)(void))didSelectMenuBlock backsideMenus:(NSArray *)backsideMenus;

@end
