//
//  RGMenuView.h
//  RGMenuTest
//
//  Created by RolandG on 17/11/2013.
//  Copyright (c) 2013 FM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGMenuView : UIView

- (id)initWithFrame:(CGRect)frame foregroundText:(NSString *)foregroundText backgroundText:(NSString *)backgroundText foregroundMenuBlock:(void (^)(void))didSelectForegroundMenuBlock backgroundMenuBlock:(void (^)(void))didSelectBackgroundMenuBlock;
- (id)initWithSize:(CGSize)size foregroundText:(NSString *)foregroundText backgroundText:(NSString *)backgroundText foregroundMenuBlock:(void (^)(void))didSelectForegroundMenuBlock backgroundMenuBlock:(void (^)(void))didSelectBackgroundMenuBlock;

@end
