//
//  DAORodada.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rodada.h"

@interface DAORodada : NSObject

+(Rodada*)fetchRodadaWithCode:(int)codigo;
+(NSArray*)fetchAllRodadas;
+(NSArray*)fetchAllRodadasOrderedByDate;

@end
 