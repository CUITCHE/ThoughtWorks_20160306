//
//  TWWorksTest.m
//  TWWorksTest
//
//  Created by hejunqiu on 16/3/6.
//  Copyright © 2016年 hejunqiu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CHCashRegister.h"

@interface TWWorksTest : XCTestCase
@property (nonatomic, strong) CHCashRegister *cashRegister;
@end

@implementation TWWorksTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _cashRegister = [[CHCashRegister alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItPerchaseWhenBarcodeNotExits
{
    // given
    for (int i=0; i<1000; ++i) {
        [_cashRegister addItemWithBarCode:[NSString stringWithFormat:@"CHITEM%05d", i]];
    }

    // when
    NSUInteger count = _cashRegister.countOfPerchased;

    // then
    XCTAssert(count == 8);
}

- (void)testThatItPerchaseWhenBarcodeWithAmount
{
    // given
    for (int i=0; i<1000; ++i) {
        [_cashRegister addItemWithBarCode:[NSString stringWithFormat:@"CHITEM%05d-%d", i, i]];
    }

    // when
    NSUInteger count = _cashRegister.countOfPerchased;

    // then
    XCTAssert(count == 36);
}

- (void)testPrint
{
    // given
    for (int i=0; i<1000; ++i) {
        [_cashRegister addItemWithBarCode:[NSString stringWithFormat:@"CHITEM%05d-%d", i % 10, i % 7]];
    }
    // when then
    // just for test print
    [_cashRegister print];
}
@end
