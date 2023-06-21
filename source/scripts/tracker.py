# *******************************************************************************************
# *******************************************************************************************
#
#		Name : 		tracker.py
#		Purpose :	Generate tracking information
#		Date :		21st June 2023
#		Author : 	Paul Robson (paul@robsons.org.uk)
#
# *******************************************************************************************
# *******************************************************************************************

import os,sys,math
from datetime import datetime

time = datetime.today().strftime('%Y-%m-%d %H:%M:%S')

h = open("scripts"+os.sep+"track.count")
n = int(h.read(-1))
h.close()

h = open("scripts"+os.sep+"track.count","w")
h.write("{0}\n".format(n+1))
h.close()

print("TrackingInfo:")
print("\t.text \"Blitz Build {0} [{1}]\",13,13,0".format(n+1,time))

