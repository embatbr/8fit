import json
import os
import sys


PROJECT_ROOT_PATH = os.environ.get('PROJECT_ROOT_PATH')


account_id = sys.argv[1]


template = json.load(open('%s/template.json' % PROJECT_ROOT_PATH))
fsm = json.load(open('%s/fsm.json' % PROJECT_ROOT_PATH))

fsm['States']['ReceiveEvent']['Resource'] = fsm['States']['ReceiveEvent']['Resource'].format(**{
    'account_id': account_id
})
template['Resources']['EventStateMachine']['Properties']['DefinitionString'] = json.dumps(fsm)

json.dump(template, open('%s/final-template.json' % PROJECT_ROOT_PATH, 'w'), indent=4)
