# From Uche Ogbuji 
# http://www.ibm.com/developerworks/xml/library/x-tipufp/

import sys
import feedparser

#List of uples (label, property-tag, truncation)
COMMON_CHANNEL_PROPERTIES = [
    ('Channel title:', 'title', None),
    ('Channel description:', 'description', 150),
    ('Channel URL:', 'link', None),
]

COMMON_ITEM_PROPERTIES = [
    ('Item title:', 'title', None),
    ('Item description:', 'description', 150),
    ('Item URL:', 'link', None),
]

INDENT = u' '*4

def feedinfo(url, output=sys.stdout):
    """
    Read an RSS or Atom feed from the given URL and output a feed
    report with all the key data
    """
    feed_data = feedparser.parse(url)
    channel, items = feed_data.feed, feed_data.entries
    #Display core feed data
    for label, prop, trunc in COMMON_CHANNEL_PROPERTIES:
        value = channel[prop]
        if trunc:
            value = value[:trunc] + u'...'
        print >> output, label, value
    print >> output
    print >> output, "Feed items:"
    for item in items:
        for label, prop, trunc in COMMON_ITEM_PROPERTIES:
            value = item[prop]
            if trunc:
                value = value[:trunc] + u'...'
            print >> output, INDENT, label, value
        print >> output, INDENT, u'---'
    return


if __name__ == "__main__":
    url = sys.argv[1]
    feedinfo(url)
