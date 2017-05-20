//
//  MDDirectionService.h
//  objc_map
//
//  Created by Guna Sundari on 10/05/17.
//  Copyright © 2017 Guna Sundari. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface MDDirectionService : NSObject
- (void)setDirectionsQuery:(NSDictionary *)object withSelector:(SEL)selector
              withDelegate:(id)delegate;
- (void)retrieveDirections:(SEL)sel withDelegate:(id)delegate;
- (void)fetchedData:(NSData *)data withSelector:(SEL)selector
       withDelegate:(id)delegate;
@end
