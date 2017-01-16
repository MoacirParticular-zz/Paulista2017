//
//  DAOArtilharia.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "DAOArtilharia.h"
#import "AppDelegate.h"

@implementation DAOArtilharia

+(Artilharia*)fetchArtilhariaWithCode:(int)codigo {
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allArtilharia = [[NSFetchRequest alloc] init];
    [allArtilharia setEntity:[NSEntityDescription entityForName:@"Artilharia" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allArtilharia setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allArtilharia error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllArtilharia
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allArtilharia = [[NSFetchRequest alloc] init];
    [allArtilharia setEntity:[NSEntityDescription entityForName:@"Artilharia" inManagedObjectContext:context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"posicaoArray" ascending:YES];
    
    [allArtilharia setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allArtilharia error:&readError];
    
    return fetchArray;
}

+(void)parseAndInsertObjectsWithJson:(NSDictionary*)json;
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSMutableArray *artilhariaArray = [json objectForKey:@"Artilharia"];
    //  NSLog(@"%@", artilhariaArray);
    
    NSArray *artilharias = [DAOArtilharia fetchAllArtilharia];
    
    for (Artilharia *artilheiro in artilharias) {
        [context deleteObject:artilheiro];
    }
    
    for (NSDictionary *dictArtilharia in artilhariaArray) {
//        Artilharia *artilharia = [DAOArtilharia fetchArtilhariaWithCode:[[dictArtilharia objectForKey:@"codigo"] intValue]];
        
    
//        if (artilharia == nil) {
            Artilharia *artilharia = [NSEntityDescription insertNewObjectForEntityForName:@"Artilharia" inManagedObjectContext:context];
            artilharia.codigo = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"codigo"] integerValue]];
            artilharia.nomeEscudo = [dictArtilharia objectForKey:@"nomeescudo"];
            artilharia.nomeJogador = [dictArtilharia objectForKey:@"nomejogador"];
            artilharia.numeroGols = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"numerogols"] integerValue]];
            artilharia.codigoJogador = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"codigojogador"] integerValue]];
            artilharia.posicao = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"posicao"] integerValue]];
            artilharia.posicaoArray = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"posicaoArray"] integerValue]];
//        }
//        else
//        {
//            artilharia.codigo = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"codigo"] integerValue]];
//            artilharia.nomeEscudo = [dictArtilharia objectForKey:@"nomeescudo"];
//            artilharia.nomeJogador = [dictArtilharia objectForKey:@"nomejogador"];
//            artilharia.numeroGols = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"numerogols"] integerValue]];
//            artilharia.codigoJogador = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"codigojogador"] integerValue]];
//            artilharia.posicao = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"posicao"] integerValue]];
//            artilharia.posicaoArray = [NSNumber numberWithInteger:[[dictArtilharia objectForKey:@"posicaoArray"] integerValue]];
//        }
    }
    
    NSError *saveError;
    
    [context save:&saveError];
}

@end

