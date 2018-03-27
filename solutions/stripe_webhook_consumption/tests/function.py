import json
import os
import sys

my_path = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, '%s/..' % my_path)

import event_extractor


events = json.load(open('%s/events.json' % my_path))
context = None
for event in events:
    ret = event_extractor.handle(event, context)
    print(json.dumps(ret, indent=4))
