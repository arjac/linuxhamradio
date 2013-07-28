#!/usr/bin/env python
# rq/64k - 2010/2011
# http://code.google.com/p/rsspy/

# imports
import os
import sys as s
import unicodedata

# check if feedparser module is installed
try: import feedparser
except ImportError:
	import webbrowser
	print "This script requires feedparser."
	webbrowser.open("http://code.google.com/p/feedparser/downloads/list")
	s.exit(0)

# usage
def usage(): s.exit("Usage:\npython rss.py [url] [number of headlines]\n\t\t\t\trq - 2010")

# error messages
def error(line):
	s.stderr.write("\033[44m\033[37m ERROR: %s \033[0m \n" % line)
	s.exit()

def remove_accents(input_str):
        nkfd_form = unicodedata.normalize('NFKD', input_str)
        only_ascii = nkfd_form.encode('ASCII', 'ignore')
        return only_ascii

# core
def core(url, hl):
	# command line arguments
	if "--help" in s.argv[1:]: usage()
	p = " > "

	# parser
	feed = feedparser.parse(url)

	# maximum headlines
	if hl > len(feed["items"]):
		hl = len(feed["items"])

	# print the feed title
	print feed.channel.title + "\n"
	
	# print the headlines
	for i in range(hl):
		print feed.entries[i].title
		noaccents = remove_accents(feed.entries[i].title)
		print noaccents
		echocommand = "echo " + "\"" + noaccents + "\""
		festivalcommand = echocommand + " | festival --language spanish --tts"
		os.system(festivalcommand)
		print

# pretty obvious what this does, huh?
def main():
	# if no arguments, print usage.
	if (s.argv[2:] == []):
		usage()
	url = str(s.argv[1])

	# headlines length must be a integer.
	try: hl = int(s.argv[2])
	except ValueError: usage()

	# feed://* is not allowed, use http://* instead.
	if (url.startswith("feed://") == True):
		error("feed:// not supported, use http:// instead.")
	# no titles? ;_;
	try:
		core(url, hl)
	except AttributeError:
		error("No titles found.")

# main 
if (__name__ == "__main__"):
	main()
