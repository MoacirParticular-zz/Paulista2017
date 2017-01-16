//
//  DAOGeral.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Geral.h"

@interface DAOGeral : NSObject

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
+(Geral*)fetchGeralWithCode:(int)codigo;
+(NSArray*)fetchAllGeral;

@end
