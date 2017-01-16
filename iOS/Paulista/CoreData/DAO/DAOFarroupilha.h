//
//  DAOFarroupilha.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Farroupilha.h"

@interface DAOFarroupilha : NSObject

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
+(Farroupilha*)fetchFarroupilhaWithCode:(int)codigo;
+(NSArray*)fetchAllFarroupilha;

@end
