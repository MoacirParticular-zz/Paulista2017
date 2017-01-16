//
//  DAOPiratini.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piratini.h"

@interface DAOPiratini : NSObject

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
+(Piratini*)fetchPiratiniWithCode:(int)codigo;
+(NSArray*)fetchAllPiratini;

@end
