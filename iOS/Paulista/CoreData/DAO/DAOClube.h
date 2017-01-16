//
//  DAOClube.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Clube.h"

@interface DAOClube : NSObject{
    
    
}

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
+(Clube*)fetchClubeWithCode:(int)codigo;
+(NSArray*)fetchAllClubes;

@end
