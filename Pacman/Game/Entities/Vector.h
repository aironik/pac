//
//  Vector.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Vector_H_
#define __Vector_H_

#include <iostream>

namespace Entities {

struct Vector {
    union {
        GLKVector2 glkVector;
        struct { float x, y; };
        float v[2];
    };

    Vector() : x(0.0f), y(0.0f) {}
    Vector(float x, float y) : x(x), y(y) {}
    Vector(const Vector &other) : x(other.x), y(other.y) {}
    Vector(const GLKVector2 &other) : x(other.x), y(other.y) {}

    Vector &operator=(const Vector &other) { x = other.x; y = other.y; return *this; }
    Vector &operator=(const GLKVector2 &other) { x = other.x; y = other.y; return *this; }
    bool operator==(const Vector &other) const { return (x == other.x && y == other.y); }
    bool operator!=(const Vector &other) const { return !operator==(other); }
    const Vector operator+(const Vector &other) const { return Vector(*this) += other; }
    const Vector operator-(const Vector &other) const { return Vector(*this) -= other; }
    const Vector operator/(const float &c) const { return Vector(*this) /= c; }
    const Vector operator*(const float &c) const { return Vector(*this) *= c; }
    Vector &operator+=(const Vector &other) { x += other.x; y += other.y; return *this; }
    Vector &operator-=(const Vector &other) { x -= other.x; y -= other.y; return *this; }
    Vector &operator*=(const float c) { x *= c; y *= c; return *this; }
    Vector &operator/=(const float c) { x /= c; y /= c; return *this; }

    void normalize() { *this = GLKVector2Normalize(this->glkVector); }
    float distance(const Vector &other) const { return GLKVector2Distance(this->glkVector, other.glkVector); }
    float length() const { return GLKVector2Length(this->glkVector); };
    Vector crossproduct(const Vector &other) const { return GLKVector2Project(this->glkVector, other.glkVector); }
    float dotproduct(const Vector &other) const { return GLKVector2DotProduct(this->glkVector, other.glkVector); }
};

} // namespace Entities

#endif //__Vector_H_
