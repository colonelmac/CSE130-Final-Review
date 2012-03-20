# Problem 3
# 
# Decorates each call to the function
# 
#

# Function decorator
def print_first_k_args(k):
    def g(f):
        def h(*args, **kwargs):
            for i, arg in enumerate(args):
                if i == k: break
                print "Arg %d: %s" % (i+1, arg)     
            ret = f(*args, **kwargs)
            print "Return: %d" % (ret)
            return ret
        return h    
    return g
        

@print_first_k_args(1)
def sum(a, b): return a + b

sum(5, 4)

@print_first_k_args(1)
def fac(n):
    if n <= 0: return 1
    else: return n * fac(n - 1)

print fac(3)
