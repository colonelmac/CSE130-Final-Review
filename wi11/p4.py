# Problem 4a 

# creates


#img1 = [[255,255, 0, 0,255,255],
#       [255,255, 0, 0,255,255],
#       [ 0, 0,255, 0, 0, 0],
#       [ 0, 0,255,255, 0, 0],
#       [255, 0, 0, 0, 0,255],
#       [ 0,255,255,255,255, 0]]

def create_image(width, height, c):
    return [[c for w in range(width)] for h in range(height)]

# Problem 4b

def well_formed(img):
    height = len(img)
    for row in img:
        for cell in row:
            if len(row) != height:
                return False
            if cell < 0 or cell > 255:
                return False
    return True

# Problem 4c

def fill_rect(img, x0, y0, x1, y1, c):
    try:
        for y in range(y0, y1):
            for x in range(x0, x1):
                img[y][x] = c
    except IndexError:
        print "oops!"

#rect = create_image(5, 5, 255)
#fill_rect(rect, 0, 0, 5, 5, 0)

# Problem 4d

img4 =  [[ 0, 3, 0, 3, 0], 
        [ 0, 3, 0, 3, 0], 
        [ 0, 0, 3, 0, 0], 
        [ 5, 0, 0, 0, 5], 
        [ 0, 5, 5, 5, 0]]

def fill_region_derrick(img, oldc, newc, x, y, c):
    img[y][x] = newc
    
    # four directions: up, down, left, right
    if y < len(img) - 1:
        if img[y + 1][x] == oldc:
            fill_region_derrick(img, oldc, newc, x, y+1, c)
    if y > 0:
        if img[y - 1][x] == oldc:
            fill_region_derrick(img, oldc, newc, x, y-1, c)

    if x < len(img) - 1:
        if img[y][x + 1] == oldc:
            fill_region_derrick(img, oldc, newc, x+1, y, c)
    
    if x > 0:
        if img[y][x - 1] == oldc:
            fill_region_derrick(img, oldc, newc, x-1, y, c)


def fill_region_sorin(img, oldc, newc, x, y, c):
    img[y][x] = newc

    print "at %d, %d" % (y, x)

    for (x1, y1) in [(x, y+1), (x, y-1), (x+1, y), (x-1, y)]:
        if x1 >= 0 and x1 <= len(img) - 1 and y1 >= 0 and y1 <= len(img) - 1:  
            if img[y1][x1] == oldc: 
                print "moving to %d, %d" % (y1, x1)
                fill_region_sorin(img, oldc, newc, x1, y1, c)

fill_region_sorin(img4, 0, 10, 1, 2, 100)

print img4


































