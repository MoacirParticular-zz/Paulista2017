//
//  DAOJogo.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jogo.h"
#import "DAORodada.h"
#import "DAOClube.h"
#import "DAOTurno.h"

@interface DAOJogo : NSObject

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
+(Jogo*)fetchJogoWithCode:(int)codigo;
+(NSArray*)fetchAllJogos;

@end
