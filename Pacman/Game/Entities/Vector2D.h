//
//  Vector2D.cpp
//  Pacman
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Vector_H_
#define __Vector_H_


namespace Entities {

struct Vector2D {
    union {
        GLKVector2 glkVector;
        struct { float x, y; };
        float v[2];
    };

    Vector2D() : x(0.0f), y(0.0f) {}
    Vector2D(float x, float y) : x(x), y(y) {}
    Vector2D(const Vector2D &other) : x(other.x), y(other.y) {}
    Vector2D(const GLKVector2 &other) : x(other.x), y(other.y) {}

    Vector2D &operator=(const Vector2D &other) { x = other.x; y = other.y; return *this; }
    Vector2D &operator=(const GLKVector2 &other) { x = other.x; y = other.y; return *this; }
    bool operator==(const Vector2D &other) const { return (x == other.x && y == other.y); }
    bool operator!=(const Vector2D &other) const { return !operator==(other); }
    const Vector2D operator+(const Vector2D &other) const { return Vector2D(*this) += other; }
    const Vector2D operator-(const Vector2D &other) const { return Vector2D(*this) -= other; }
    const Vector2D operator/(const float &c) const { return Vector2D(*this) /= c; }
    const Vector2D operator*(const float &c) const { return Vector2D(*this) *= c; }
    Vector2D &operator+=(const Vector2D &other) { x += other.x; y += other.y; return *this; }
    Vector2D &operator-=(const Vector2D &other) { x -= other.x; y -= other.y; return *this; }
    Vector2D &operator*=(const float c) { x *= c; y *= c; return *this; }
    Vector2D &operator/=(const float c) { x /= c; y /= c; return *this; }

    void normalize() { *this = GLKVector2Normalize(this->glkVector); }
    float distance(const Vector2D &other) const { return GLKVector2Distance(this->glkVector, other.glkVector); }
    float length() const { return GLKVector2Length(this->glkVector); };
    Vector2D crossproduct(const Vector2D &other) const { return GLKVector2Project(this->glkVector, other.glkVector); }
    float dotproduct(const Vector2D &other) const { return GLKVector2DotProduct(this->glkVector, other.glkVector); }

    GLKVector3 upSize(float z) { return GLKVector3Make(x, y, z); }
};


} // namespace Entities

#endif //__Vector_H_
