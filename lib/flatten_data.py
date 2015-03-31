#!/usr/bin/env python

import json
import collections
import sys

def read_json_file(filename):
    with open(filename, "r") as file:
        return json.loads(file.read())

def flatten(l):
    if not isinstance(l, collections.Iterable):
        yield l
    else: 
        for el in l:
            if isinstance(el, collections.Iterable) and not isinstance(el, basestring):
                for sub in flatten(el):
                    yield sub
            else:
                yield el

if __name__ == '__main__':
    if len(sys.argv) < 3:
        exit("Usage: %s <file> <field>" % sys.argv[0])
    else:
        json_file = sys.argv[1]
        field = sys.argv[2]
        data = read_json_file(json_file)
        try:
            print("\n".join(map(repr, flatten(data[field]))))
        except KeyError:
            exit("Key %s not found in JSON file." % field)
