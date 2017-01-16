//
//  DAOArtilharia.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artilharia.h"

@interface DAOArtilharia : NSObject

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
+(Artilharia*)fetchArtilhariaWithCode:(int)codigo;
+(NSArray*)fetchAllArtilharia;

@end

