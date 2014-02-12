#!/usr/local/python/bin/python2.7

import re 
import time

ptrn = re.compile('\[([0-9]+)\](.*)')

def main():

    with open('nagios-02-08-2014-00.log') as f:

        for line in f:

            mo = ptrn.match(line)
            date = conv(int(mo.group(1)))
            message = mo.group(2)
#            print '[%s]%s' % (date, message)
            d=' {0} {1}'.format(date,message)
            print d
            print ' '
def conv(date):
    forma = '%Y-%m-%d %H:%M:%S'
    day = time.localtime(date)

    dt = time.strftime(forma, day)
    return dt    
if __name__ == '__main__':
    main()

