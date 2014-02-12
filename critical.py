#!/usr/local/python/bin/python2.7
# The log of nagios conversion time

import re 
import time


hostname = raw_input('Please enter a hostname which you will find:\n')
ptrn = re.compile('\[([0-9]+)\](.*)')

def main():

    with open('nagios.log') as f:
        for line in f:
            mo = ptrn.match(line)
            date = conv(int(mo.group(1)))
            message1 = mo.group(2)

            if hostname in message1:
                message=message1
#            print '[%s]%s' % (date, message_log)
                d=' {0} {1}'.format(date,message)
                print d
                print ' '
            else:
                continue
    print '''Sorry, we don't have to find out more about %s''' % hostname

def conv(date):
    forma = '%Y-%m-%d %H:%M:%S'
    day = time.localtime(date)
    dt = time.strftime(forma, day)
    return dt    

if __name__ == '__main__':
    main()

