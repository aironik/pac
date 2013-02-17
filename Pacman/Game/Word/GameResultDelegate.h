//
//  GameResultDelegate.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#ifndef __GameResultDelegate_H_
#define __GameResultDelegate_H_

#import <memory>


namespace Word {

struct GameResultDelegate {
    typedef std::shared_ptr<GameResultDelegate> SharedPtr;
    typedef std::weak_ptr<GameResultDelegate> WeakPtr;

    virtual ~GameResultDelegate() {}

    virtual void gameWin() = 0;
    virtual void gameLose() = 0;
    virtual void gameScoreDidIncremened(int score) = 0;
};

} // namespace Word

#endif //__GameResultDelegate_H_
