//
//  CHItemEntity.h
//  ThoughtWorks_20160306
//
//  Created by hejunqiu on 16/3/6.
//  Copyright © 2016年 hejunqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CHPreferentialType) {
    CHPreferentialTypeNone,
    CHPreferentialType3For2 = 1,
    CHPreferentialType5Off = 1 << 1
};

@interface CHItemEntity : NSObject
@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString *unit;

@property (nonatomic, strong) NSString *barcode;
@property (nonatomic, assign) NSInteger preferentialType;

+ (instancetype)itemEntityWithCategory:(NSString *)category
                                  name:(NSString *)name
                                 price:(CGFloat)price
                                  unit:(NSString *)unit
                               barcode:(NSString *)barcode
                      preferentialType:(NSInteger)type;
@end


@interface CHDatabase : NSObject

/**
 * @author hejunqiu, 16-03-06 22:03:53
 *
 * This is test databse.
 *
 * @return A dictionary value that its key represents barcode and its value represents
 * item-entity.
 */
+ (NSDictionary<NSString *, CHItemEntity *> *)itemSetFortest;

/**
 * @author hejunqiu, 16-03-06 15:03:16
 *
 * We assume that this is from database for validating the Legitimacy of barcode.
 *
 * @param barcode A string value of barcode.
 *
 * @return Return a bool value. If the barcode exits, return YES. Otherwise is NO.
 */
+ (BOOL)barcodeIsVaild:(NSString *)barcode;

@end


@interface CHSettlementEntity : NSObject

@property (nonatomic, strong) NSString *barcode;
@property (nonatomic) NSInteger count;

@property (nonatomic) CGFloat free;
@property (nonatomic) NSInteger freeCount;

@property (nonatomic) CGFloat subtotal;
@end