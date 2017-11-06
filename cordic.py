import math

ANGLE = 32

def cordic(target, angles, tan, sin, cos):
    currAngle = target
    currTan = tan[0]
    currSin = 0
    currCos = gain(cos)

    for i in range(0, len(angles)):

        print("currCos =", currCos, "currSin =", currSin)

        if currAngle <= 0:
            currAngle += angles[i]
            
            newCos = currCos + (currSin * 2.0**(-i))
            newSin = currSin - (currCos * 2.0**(-i))
            
            currCos = newCos
            currSin = newSin

            currTan += tan[i]


        elif currAngle > 0:
            currAngle -= angles[i]

            newCos = currCos - (currSin * 2.0**(-i))
            newSin = currSin + (currCos * 2.0**(-i))

            currCos = newCos
            currSin = newSin

            currTan -= tan[i]

    print ("currSin =", currSin, "currCos =", currCos)
    

def gain(cosTable):
    gain = 1
    for i in range(len(cosTable)):
        gain *= cosTable[i]

    return gain

def main():

    anglesTan = [45.0, 26.6, 14.0, 7.1, 3.6, 1.8, 0.9, 0.4, 0.2, 0.1]

    tan = [1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015635, 0.0078125, 0.00390625, 0.001953125]

    sin = [0.707, 0.448, 0.242, 0.124, 0.063, 0.0314, 0.016, .007, .0035, .0017]

    cos = [0.707, 0.894, 0.970, 0.992, 0.998, 0.999, 1, 1, 1, 1]

    cordic(ANGLE, anglesTan, tan, sin, cos)

    
    
    


main()
