//
//  APRenderer.m
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 27.01.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "APRenderer.h"

#import "Labyrinth.h"

namespace {

struct GameResultDelegateImpl : public Word::GameResultDelegate {
    typedef std::shared_ptr<GameResultDelegateImpl> SharedPtr;
    GameResultDelegateImpl() : renderer(nil) {}
    GameResultDelegateImpl(APRenderer *aRenderer) : renderer(aRenderer) {}
    virtual ~GameResultDelegateImpl() { renderer = nil; }

    virtual void gameWin() { [renderer win]; }
    virtual void gameLose() { [renderer lose]; }

    __weak APRenderer *renderer;
};

} // namespace ::


@interface APRenderer () {
    Word::Labyrinth::SharedPtr _word;
    GameResultDelegateImpl::SharedPtr _gameResultDelegateImpl;
}


@end


#pragma mark - Implementation

@implementation APRenderer

- (id)init {
    if (self = [super init]) {
        [self setupWord];
    }
    return self;
}

- (void)dealloc {
    [self destroyWord];
}

- (void)setupWord {
    _gameResultDelegateImpl = ::GameResultDelegateImpl::SharedPtr::make_shared(self);
    _word = Word::Labyrinth::createLabyrinth(0);
    _word->setGameResultDelegate(_gameResultDelegateImpl);
}

- (void)destroyWord {
    _word.reset();
    _gameResultDelegateImpl.reset();
}

- (void)update:(NSTimeInterval)timeInterval {
    _word->update(timeInterval);
}

- (void)render {
    _word->draw();
}

- (void)setUserInput:(GLKVector2)direction {
    _word->handleUserInput(direction);
}

- (void)win {
    // TODO: write me
}

- (void)lose {
    // TODO: write me
}

@end