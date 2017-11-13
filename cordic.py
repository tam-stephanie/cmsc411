import math

ANGLE = 80.1


def division(dividend, divisor, precision):
    whole = 0 
    iterate = 0
    while iterate < precision:
        
        while dividend >= divisor:
            whole += 1 * 2**(-iterate)
            dividend -= divisor
            
        
        divisor = divisor * 2**-1

        iterate += 1

    return whole

        


def cordic_h(target, angles, tanh):
    # z
    currAngle = target
    # y 
    currSinh = 0
    # x
    currCosh = find_An_hyper(len(angles))

    for i in range(0, len(angles)):

        if currAngle <= 0:
            currAngle += angles[i]
            
            newCosh = currCosh + (currSinh * 2.0**(-i))
            newSinh = currSinh - (currCosh * 2.0**(-i))
            
            currCosh = newCosh
            currSinh = newSinh


        elif currAngle > 0:
            currAngle -= angles[i]

            newCosh = currCosh - (currSinh * 2.0**(-i))
            newSinh = currSinh + (currCosh * 2.0**(-i))

            currCosh = newCosh
            currSinh = newSinh


    return currSinh, currCosh







# Performs the cordic rotation to calculate sine and cosine
def cordic(target, angles, tan, sin, cos):
    # z
    currAngle = target
    # y
    currSin = 0
    # x
    currCos = 1 / find_An(len(angles))

    for i in range(0, len(angles)):

        if currAngle <= 0:
            currAngle += angles[i]
            
            newCos = currCos + (currSin * 2.0**(-i))
            newSin = currSin - (currCos * 2.0**(-i))
            
            currCos = newCos
            currSin = newSin


        elif currAngle > 0:
            currAngle -= angles[i]

            newCos = currCos - (currSin * 2.0**(-i))
            newSin = currSin + (currCos * 2.0**(-i))

            currCos = newCos
            currSin = newSin


    return currSin, currCos

# Calculates the gain
def gain(cosTable):
    gain = 1
    for i in range(len(cosTable)):
        gain *= cosTable[i]

    return gain


def find_An(n):
    An = math.sqrt(2)
    for i in range(1,n):
        An = An * math.sqrt(1 + 2**(-2*i))
    print (An)
    return An


def find_An_hyper(n):
    An = math.sqrt(2)
    for i in range(1,n):
        An = An * math.sqrt(1 - 2**(-2*i))
    return An


def main():

    anglesTan = [45.0, 26.6, 14.0, 7.1, 3.6, 1.8, 0.9, 0.4, 0.2, 0.1]

    tan = [1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015635, 0.0078125, 0.00390625, 0.001953125]

    sin = [0.707, 0.448, 0.242, 0.124, 0.063, 0.0314, 0.016, .007, .0035, .0017]

    cos = [0.707, 0.894, 0.970, 0.992, 0.998, 0.999, 1, 1, 1, 1]

    
    corSin, corCos = cordic(ANGLE, anglesTan, tan, sin, cos)
       
    corTan = division(corSin,corCos,10)

    corSinh, corCosh = cordic_h(ANGLE, anglesTan, tan)

    print(corSinh, corCosh)
    
    print("angle =", ANGLE)
    print("sin =", corSin, "cos =", corCos, "tan =", corTan)

main()

