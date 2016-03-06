//
//  CHCashRegister.h
//  ThoughtWorks_20160306
//
//  Created by hejunqiu on 16/3/6.
//  Copyright © 2016年 hejunqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCashRegister : NSObject
/// Get count that user has perchased. It's convenient for test.
@property (nonatomic, readonly) NSUInteger countOfPerchased;


- (void)addItemWithBarCode:(NSString *)barcode;
- (void)print;

+ (void)justForTest;
@end
