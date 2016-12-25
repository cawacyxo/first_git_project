#!/usr/bin/env python

# Working with unzip in python
import sys
import subprocess
import os.path
import re
from xml.dom import minidom

UBF_file = ''
XML_file = ''

'''
Check here number of arguments
Exit if number of arg less then 
'''
if len(sys.argv) < 3:
	print 'Expected 2 arguments'
	print 'Full path and name of UBF file'
	print 'Full path and name of pom.xml'
	sys.exit(1)

'''
Check that file exists
'''
if not os.path.exists(sys.argv[1]):
	print 'File \"' + sys.argv[1] + '\" does not exist'
	sys.exit(2)
else:
    UBF_file = sys.argv[1]


if not os.path.exists(sys.argv[2]):
	print 'File \"' + sys.argv[2] + '\" does not exist'
	sys.exit(2)
else:
    XML_file = sys.argv[2]

# Open ubf file
p = subprocess.Popen(['unzip', '-l', UBF_file], stdout=subprocess.PIPE)
result = p.communicate()[0].split()
# print result
id_names = []
art_names = []
versions = []
for i in range(0, len(result)):
    m = re.search (r'([\w\-]+)\/([\w\-]+)\-([\d\.]+)([\-\w]+)?\.(jar|sdu|xar)$', result[i])
    if m:
        id_names.append(m.group(1))
        art_names.append(m.group(2))
        versions.append(m.group(3))


#
# Working with XML
# 
doc = minidom.parse(XML_file)
for node in doc.getElementsByTagName("patch"):
    id = node.getElementsByTagName("id")[0].firstChild.data
    if id in id_names:
        art = node.getElementsByTagName("artifactId")[0].firstChild.data
        if art in art_names:
            indx = art_names.index(art)
            node.getElementsByTagName("version")[0].firstChild.data = versions[indx]


new_XML = XML_file + '.new'
f = open (new_XML, 'w')
f.write(doc.toxml())
f.close()


