
def tracked(cl):
    currId = 0
    instances = dict()

    class tracker(cl):
        def __init__(self, *args):
            cl.__init__(self, *args) # call child ctor
            print currId
            currId += 1
            self.instId = currId
            instances[self.instId] = self
            
        def getInst(self):
            return instances[self.instId]
    
    return tracker

class C:
    def __init__(self, v):
        self.x = v

C = tracked(C)

c1 = C("Jack")
c2 = C([0,1,2])
c3 = C(2004)

print c1.getInst().x